//
//  UserModel.swift
//  TestMapDemo (iOS)
//
//  Created by Tariqul on 12/11/21.
//

import Foundation
class UserModel {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
