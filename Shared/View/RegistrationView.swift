//
//  RegistrationView.swift
//  TestMapDemo (iOS)
//
//  Created by Tariqul on 12/11/21.
//


import SwiftUI
import CustomLoadingButton

struct RegistrationView: View {
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
            Text("Create New Account")
                .foregroundColor(Color("text_color_1"))
                .titleStyle(fontSize: 25)
            
            VStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading){
                    
                    Text("Name")
                        .foregroundColor(Color("text_color_1"))
                        .titleStyle(fontSize: 20)
                        .padding(.top, 20)
                    
                    
                    TextField("", text: $viewModel.name)
                        .foregroundColor(.white)
                        .placeholder(when: viewModel.name.isEmpty) {
                            Text("Name").foregroundColor(Color("light_gray"))}
                    
                    Text(viewModel.nameError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                        .padding(.bottom, 20)
                    
                    Text("E-mail")
                        .foregroundColor(Color("text_color_1"))
                        .titleStyle(fontSize: 20)
                        .padding(.top, 20)
                    
                    
                    TextField("", text: $viewModel.email)
                        .foregroundColor(.white)
                        .placeholder(when: viewModel.email.isEmpty) {
                            Text("E-mail").foregroundColor(Color("light_gray"))}
                    
                    Text(viewModel.emailError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                        .padding(.bottom, 20)
                    
                    Text("Password")
                        .foregroundColor(Color("text_color_1"))
                        .titleStyle(fontSize: 20)
                        .padding(.top, 20)

                    SecureInputView("Password", text: $viewModel.password)
                    
                    
                    Text(viewModel.passwordError)
                        .foregroundColor(.red)
                        .titleStyle(fontSize: 10)
                        .padding(.bottom, 30)
                }
                
                CustomLoadingButton(action: {
                    signUp(name: viewModel.name, email: viewModel.email, password: viewModel.password)
                }, isLoading: $viewModel.isLoading, style: style)
                {
                    HStack{
                        Text("Create")
                            .foregroundColor(.white)
                            .titleStyle(fontSize: 25)
                    }
                }
                
            }.padding([.horizontal], 20)
            Spacer()

            HStack{
                Text("Already have an account?")                .foregroundColor(Color("text_color_1"))
                    .titleStyle(fontSize: 14)
                Text("LogIn")
                    .foregroundColor(.orange)
                    .titleStyle(fontSize: 14)
            } .padding(.top, 40)
                .onTapGesture {
                    viewModel.isShowingRegistration = true
                  }
            
            NavigationLink(destination: LoginView(viewModel: AuthViewModel()).navigationBarBackButtonHidden(true), isActive: $viewModel.isShowingRegistration) { EmptyView().navigationBarTitle("")
                          .navigationBarHidden(true) }
            
        } .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text("Login status"), message: Text("User name or password not matched, please type correct username, password"), dismissButton: .default(Text("Got it!")))
        }
    }
    func signUp(name: String, email: String, password: String) {
            print("sign me up")
            viewModel.signUp(name: name, email: email, password: password) { (result, error) in
                if error != nil {
                    print("\(error)")
                    self.viewModel.showingAlert = true
                } else {
                    print("success full")
                }
            }
        }
}
