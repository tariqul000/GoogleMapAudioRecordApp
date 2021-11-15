//
//  RecordDetailsModel.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import Foundation

class RecordDetailsModel: NSObject, NSCoding {
    
    
    var fileURL: URL = URL(fileURLWithPath: "")
    var createdAt: String = ""
    var title: String = ""
    var latitude: String = ""
    var longitude: String = ""

    
    init(fileURL: URL ,createdAt : String, title : String, latitude: String, longitude: String){
        self.fileURL = fileURL
        self.createdAt = createdAt
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
     
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fileURL, forKey: "fileURL")
        aCoder.encode(createdAt, forKey: "createdAt")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.fileURL = aDecoder.decodeObject(forKey: "fileURL") as! URL
        self.createdAt = aDecoder.decodeObject(forKey: "createdAt") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.latitude = aDecoder.decodeObject(forKey: "latitude") as! String
        self.longitude = aDecoder.decodeObject(forKey: "longitude") as! String
    }
}
