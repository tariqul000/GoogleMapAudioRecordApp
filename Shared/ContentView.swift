//
//  ContentView.swift
//  Shared
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                        LoginView(viewModel: AuthViewModel())
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
