//
//  GoogleMapView.swift
//  TestMapDemo (iOS)
//
//  Created by Tariqul on 12/11/21.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Foundation


struct GoogleMapView: View {
    @State var labelNumber = 15
    @ObservedObject var viewModel: AuthViewModel
    @ObservedObject var audioRecorder: AudioRecorder
    @State var goTorecordingList = false

    var body: some View {
        ZStack(alignment: .bottom){
            GoogMapControllerRepresentable()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center){
                if audioRecorder.recording == false {
                    Button(action: {print(self.audioRecorder.startRecording(title: ""))}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                
                HStack{
                 
                    Image("recorded")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .onTapGesture(perform: {
                            goTorecordingList = true
                        })
                Spacer()
                
                Image(systemName: "bell").foregroundColor(Color.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .font(.system(size: 20)).overlay(NotificationNumLabel(digit: $labelNumber))//digit: $labelNumber
                Spacer()
                Image("signout")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .onTapGesture(perform: {
                        if viewModel.signOut(){
                            viewModel.goToLogin = true
                        }
                    })
                }.padding(.horizontal, 20)
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                    .background(.gray)
            }
            
            
            NavigationLink(destination: LoginView(viewModel: AuthViewModel()).navigationBarBackButtonHidden(true), isActive: $viewModel.goToLogin) { EmptyView().navigationBarTitle("")
                .navigationBarHidden(true) }
            
            NavigationLink(destination: RecordingsList(audioRecorder: audioRecorder), isActive: $goTorecordingList) { EmptyView().navigationBarTitle("Recording List")
               }
        }
        
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(viewModel: AuthViewModel(), audioRecorder: AudioRecorder())
    }
}
