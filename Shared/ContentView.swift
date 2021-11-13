//
//  ContentView.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    
    var body: some View {
        Group {
           
            if (Auth.auth().currentUser != nil) {
                NavigationView {
                    GoogleMapView(viewModel: AuthViewModel())
                }
                .navigationViewStyle(StackNavigationViewStyle())
            
            } else {
                NavigationView {
                    LoginView(viewModel: AuthViewModel())
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
