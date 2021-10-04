//
//  ImageViewModel.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 02/10/21.
//

import Foundation
import CoreData

class ImageViewModel:NSObject{
    
    var galleryImages = [ImageModel]()
    
    func getImages(startDate:String, endDate:String, handler:@escaping (Bool, String)->Void){
        ServerManager.request(router: ServerRequest.getImages(startDate, endDate)) {[weak self] (result:Result<[ImageModel],NetworkError>) in
            
            switch result{
            case .success(let response):
                self?.galleryImages.removeAll()
                self?.galleryImages = response
                handler(true, "Success")
                break
                
            case .failure(let error):
                handler(false, error.description)
                break
            }
        }
    }
    
    func checkIfFav(imageDetail:ImageModel)->Bool{
        let favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        let itemIndex = favItems.firstIndex{$0.title == imageDetail.title}
        if itemIndex != nil{
            return true
        }
        return false
    }
    
    func markFav(imageDetail:ImageModel){
        var favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        favItems.append(imageDetail)
        PersistenceMangaer.saveFavImages(domainSchema: favItems, key: Constants.bookmarkedItems)
    }
    
    func unMarkAsFav(imageDetail:ImageModel){
        var favItems = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        favItems.removeAll{
            $0.title == imageDetail.title
        }
        PersistenceMangaer.saveFavImages(domainSchema: favItems, key: Constants.bookmarkedItems)
    }
}
