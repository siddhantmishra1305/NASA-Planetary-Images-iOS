//
//  ServerRequestEnum.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 02/10/21.
//

import Foundation

enum ServerRequest{
    case getImage(String)
    case getImages(String, String)
    
    private static let baseURLString = "https://api.nasa.gov"
    private static let API_KEY = "Wg9zXPt7SgU1JQJpXMWLfCcWIBPwTYdcYq58vHQh"
    
    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method:HTTPMethod{
        switch self {
        case .getImage, .getImages:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getImage, .getImages:
            return "/planetary/apod"
        }
    }
    
    func request() throws -> URLRequest? {
        var urlString = "\(ServerRequest.baseURLString)\(path)"
        
        switch self {
        case .getImage(let selectedDate):
            var params : [String : String] = ["api_key" : ServerRequest.API_KEY]
            params["date"] = selectedDate
            
            encodeURL(path: &urlString, params: params)
            guard let url = URL(string: urlString) else{
                return nil
            }
            
            var urlRequest = URLRequest(url:url)
            urlRequest.httpMethod = method.value
            return urlRequest
            
        case .getImages(let startDate, let endDate):
            var params : [String : String] = ["api_key" : ServerRequest.API_KEY]
            params["start_date"] = startDate
            params["end_date"] = endDate
            
            encodeURL(path: &urlString, params: params)
            guard let url = URL(string: urlString) else{
                return nil
            }
            
            var urlRequest = URLRequest(url:url)
            urlRequest.httpMethod = method.value
            return urlRequest
        }
    }
    
    /// This function encodes parameters to a URL
    private func encodeURL(path:inout String, params:[String:String]){
        var component = URLComponents(string: path)
        var queryItemArr = [URLQueryItem]()
        for item in params.keys{
            queryItemArr.append(URLQueryItem(name: item, value: params[item]))
        }
        component?.queryItems = queryItemArr
        let editedComponents = component?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        component?.percentEncodedQuery = editedComponents
        
        path = component?.url?.absoluteString ?? ""
        
    }
}
