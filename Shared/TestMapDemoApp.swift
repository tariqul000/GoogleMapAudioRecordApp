//
//  TestMapDemoApp.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import Firebase

@main
struct TestMapDemoApp: App {
    
    init() {
       FirebaseApp.configure()
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: AuthViewModel())
        }
    }
}
