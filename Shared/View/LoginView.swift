//
//  LoginView.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import SwiftUI
import CustomLoadingButton

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    
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
            Spacer()
            Text("Welcome Map Test Project")
                .foregroundColor(Color("text_color_1"))
                .titleStyle(fontSize: 25)
            
            VStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading){
                    
                    
                    TextField("", text: $viewModel.email)
                        .foregroundColor(.white)
                        .placeholder(when: viewModel.email.isEmpty) {
                            Text("E-mail").foregroundColor(Color("light_gray"))}
                    
                    Text(viewModel.emailError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                        .padding(.bottom, 20)
                  
    
                    SecureInputView("Password", text: $viewModel.password)
                    
                    
                    Text(viewModel.passwordError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                        .padding(.bottom, 30)
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
            
            Spacer()
            HStack{
            Text("Don’t have an account, yet?")
                    .foregroundColor(Color("text_color_1"))
                .titleStyle(fontSize: 14)
            Text("Create an account")
                    .foregroundColor(.orange)
                    .titleStyle(fontSize: 14)
            } .padding(.bottom, 40)
              .onTapGesture {
                  viewModel.isShowingRegistration = true
                }
            NavigationLink(destination: RegistrationView(viewModel: AuthViewModel()), isActive: $viewModel.isShowingRegistration) { EmptyView().navigationBarTitle("")
                          .navigationBarHidden(true) }

            
        } .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Login status"), message: Text("User name or password not matched, please type correct username, password"), dismissButton: .default(Text("Got it!")))
        }
    }
    
}
