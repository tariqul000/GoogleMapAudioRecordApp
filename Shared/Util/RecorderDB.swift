//
//  RecorderDB.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import Foundation

enum RecorderDB{
    
    static let recordedDetailsModel = "recordedDetailsModel"
    
    static func removeUserData() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    static func save(value: [RecordDetailsModel]) {  // or forKey defaultName: String = dataKey
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) else { return }
        UserDefaults.standard.set(data, forKey: recordedDetailsModel)
    }

    static func getRecordDetials() ->  [RecordDetailsModel]? {  // or forKey defaultName: String = dataKey
        guard let data = UserDefaults.standard.data(forKey: recordedDetailsModel) else { return nil }
        guard let recordData = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as?  [RecordDetailsModel] else { return nil }
        return  recordData
    }
    
    static func removeRecordDetials(createAt: String , list: [RecordDetailsModel]) {  // or forKey defaultName: String = dataKey
        var list2 :  [RecordDetailsModel] = list
        if let index = list.firstIndex(where: {$0.createdAt == createAt}){
            list2.remove(at: index)
        }
        save(value: list2)
    }
    
    static func editRecordDetials(createAt: String , title: String, list: [RecordDetailsModel]) {  // or forKey defaultName: String = dataKey
        let list2 :  [RecordDetailsModel] = list
        if let index = list.firstIndex(where: {$0.createdAt == createAt}){
            list2[index].title = title
        }
        save(value: list2)
    }
    
    static func getAudioFile(audioFileName : String) ->  URL {  // or forKey defaultName: String = dataKey
        let list :  [RecordDetailsModel] = getRecordDetials() ?? []
        if let index = list.firstIndex(where: {$0.createdAt == audioFileName}){
            print("path \(list[index].fileURL)")
            return list[index].fileURL
            
        }
        return URL(fileURLWithPath: "")
    }
}

