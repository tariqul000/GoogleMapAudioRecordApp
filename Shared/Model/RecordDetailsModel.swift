//
//  RecordDetailsModel.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import Foundation

class RecordDetailsModel: NSObject, NSCoding {


var fileURL:String = ""
var createdAt:String = ""
var title:String = ""

init(fileURL: String ,createdAt : String, title : String){
    self.fileURL = fileURL
    self.createdAt = createdAt
    self.title = title
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(fileURL, forKey: "fileURL")
    aCoder.encode(createdAt, forKey: "createdAt")
    aCoder.encode(title, forKey: "title")
}

required init?(coder aDecoder: NSCoder) {
    self.fileURL = aDecoder.decodeObject(forKey: "fileURL") as! String
    self.createdAt = aDecoder.decodeObject(forKey: "createdAt") as! String
    self.title = aDecoder.decodeObject(forKey: "title") as! String
    }
}
