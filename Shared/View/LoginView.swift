//
//  LoginView.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import CustomLoadingButton

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var style = LoadingButtonStyle(
        height: 54,
        cornerRadius: 10,
        backgroundColor: .orange,
        loadingColor: Color.orange.opacity(0.5),
        strokeWidth: 5,
        strokeColor: .orange,
        progressType: ProgressType.circleProgress)
    
    
    var body: some View {
        contentBody()
    }
    
    private func contentBody() -> some View {
        
        VStack(alignment: .center, spacing: 30){
            
            Text("Welcome Map Test Project")
                .titleStyle(fontSize: 25)
            
            
            VStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading){
                    
                    TextField("E-mail", text: $viewModel.email)
                        .textFieldStyle(OvalTextFieldStyle())
                    
                    Text(viewModel.emailError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                  
                    TextField("Password", text: $viewModel.password)
                        .textFieldStyle(OvalTextFieldStyle())
                    
                    Text(viewModel.passwordError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                }
                
                CustomLoadingButton(action: {
                   
                }, isLoading: $viewModel.isLoading, style: style)
                {
                    HStack{
                        Text("LogIn")
                            .foregroundColor(.white)
                            .titleStyle(fontSize: 25)
                    }
                }
                
            }.padding([.horizontal], 20)
            
            Text("Don't have an account, Sign Up?")
                .titleStyle(fontSize: 14)
                .padding(.top, 20)
            
        } .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Login status"), message: Text("User name or password not matched, please type correct username, password"), dismissButton: .default(Text("Got it!")))
        }
    }
    
}
