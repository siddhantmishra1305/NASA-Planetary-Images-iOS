//
//  PersistanceManager.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 04/10/21.
//

import Foundation

struct PersistenceMangaer{
    
    static let defaults = UserDefaults.standard
    private init(){}
    
    // save Data method
    static func saveFavImages(domainSchema: [ImageModel],key:String){
        do{
            let encoder = JSONEncoder()
            let domainsSchema = try encoder.encode(domainSchema)
            defaults.setValue(domainsSchema, forKey: key)
        }catch let err{
            print(err)
        }
    }
    
    //retrieve data method
    static func getFavImages(key:String) -> [ImageModel]{
        
        guard let domainSchemaData = defaults.object(forKey: key) as? Data else { return [ImageModel]() }
        do{
            let decoder = JSONDecoder()
            let domainsSchema = try decoder.decode([ImageModel].self, from: domainSchemaData)
            return domainsSchema
        }catch let err{
            print(err)
            return [ImageModel]()
        }
    }
}
