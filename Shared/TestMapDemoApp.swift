//
//  TestMapDemoApp.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import Firebase
import GoogleMaps
import GooglePlaces


@main
struct TestMapDemoApp: App {
    
    init() {
       FirebaseApp.configure()
       GMSPlacesClient.provideAPIKey("AIzaSyA3zhMMXy2h2FmStp0QLrJ7BNSNVyBpDv8")
       GMSServices.provideAPIKey("AIzaSyA3zhMMXy2h2FmStp0QLrJ7BNSNVyBpDv8")
     }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

