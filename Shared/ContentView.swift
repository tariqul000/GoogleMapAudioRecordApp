//
//  ContentView.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if (viewModel.session != nil) {
                Text("Hello user!")
            } else {
                NavigationView {
                    LoginView(viewModel: AuthViewModel())
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .onAppear(perform: getUser)
        
        
    }
    func getUser () {
        viewModel.listen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AuthViewModel())
    }
}
