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
        guard let bloodData = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as?  [RecordDetailsModel] else { return nil }
        return  bloodData
    }
}

