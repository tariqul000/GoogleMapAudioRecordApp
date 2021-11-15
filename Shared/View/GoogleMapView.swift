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
import UserNotifications


struct GoogleMapView: View {
    @State var labelNumber = 0
    @ObservedObject var viewModel: AuthViewModel
    @ObservedObject var audioRecorder: AudioRecorder
    @State var goTorecordingList = false
    @State var title: String = ""
    @State var audioFileName: String = Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")
    //@State var lat: Double = 0.0
    // @State var lang: Double = 0.0
    @State var error: Bool = false
    @State var clickMarker: Bool = false
    @ObservedObject var audioPlayer = AudioPlayer()
    var body: some View {
        ZStack(alignment: .bottom){
            GoogMapControllerRepresentable(isClicked: $clickMarker)
                .edgesIgnoringSafeArea(.all)
            
            
            
            VStack(alignment: .center){
                if audioRecorder.recording == false {
                    Button(action: {
                        
                        print(" lat \(NotificationHelper.lat)")
                        if NotificationHelper.lat != "0.0"{
                            title = ""
                            audioFileName = Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")
                            self.audioRecorder.startRecording(title: title, audioFileName: audioFileName, lat: NotificationHelper.lat, lang: NotificationHelper.long)
                        }else{
                            error = true
                        }
                        
                    }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    withAnimation {
                        stopRecordingView()
                            .padding(.horizontal, 20)
                            .background(.gray)
                    }
                }
                
                
                
                if !clickMarker{
                    withAnimation {
                        bottomBarView()
                    }
                }else{
                    withAnimation {
                        bottomPlayerView()
                    }
                }
                
            }.alert(isPresented: $error) {
                Alert(title: Text("Location select"), message: Text("Please select a location recording voice"), dismissButton: .default(Text("Got it!")))
            }
            
            NavigationLink(destination: LoginView(viewModel: AuthViewModel()).navigationBarBackButtonHidden(true), isActive: $viewModel.goToLogin) { EmptyView().navigationBarTitle("")
                .navigationBarHidden(true) }
            
            NavigationLink(destination: RecordingsList(audioRecorder: audioRecorder), isActive: $goTorecordingList) { EmptyView().navigationBarTitle("Recording List")
            }
        }
        
    }
    
    private func stopRecordingView() -> some View {
        VStack(alignment: .center, spacing: 5){
            
            TextField("", text: $title)
                .foregroundColor(.white)
                .placeholder(when: title.isEmpty) {
                    Text(audioFileName).foregroundColor(Color("light_gray"))}
                .padding(.top, 10)
            
            Button(action: {
                self.audioRecorder.stopRecording(title: title, audioFileName: audioFileName)
                
                labelNumber = 1
                
            }) {
                Image(systemName: "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .background(.gray)
    }
    
    private func bottomBarView() -> some View {
        HStack{
            Image("recorded")
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .onTapGesture(perform: {
                    goTorecordingList = true
                    NotificationHelper.setNotification()
                })
            Spacer()
            if labelNumber == 0 {
                Image(systemName: "bell").foregroundColor(Color.white)
                    .frame(width: 50, height: 50, alignment: .center)
            }else{
                Image(systemName: "bell").foregroundColor(Color.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .font(.system(size: 20)).overlay(NotificationNumLabel(digit: $labelNumber))
                    .onTapGesture(perform: {
                        goTorecordingList = true
                    })
            }//digit: $labelNumber
            Spacer()
            Image("signout")
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .onTapGesture(perform: {
                    if viewModel.signOut(){
                        viewModel.goToLogin = true
                    }
                    
                //  //  NotificationHelper.enableNotification()
                   
                })
        }.padding(.horizontal, 20)
            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
            .background(.gray)
        
    }
    
    private func bottomPlayerView() -> some View {
        HStack{
            if audioPlayer.isPlaying == false {
                Button(action: {
                    print("path \(RecorderDB.getAudioFile(audioFileName: audioFileName))")
                    
                    self.audioPlayer.startPlayback(audio: RecorderDB.getAudioFile(audioFileName: audioFileName))
                }) {
                    Image(systemName: "play.circle")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .imageScale(.medium)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .imageScale(.medium)
                }
            }
        }.padding(.horizontal, 20)
            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
            .background(.gray)
            .onTapGesture(perform: {
                clickMarker.toggle()
            })
        
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(viewModel: AuthViewModel(), audioRecorder: AudioRecorder())
    }
}
 
