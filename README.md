# TestMapDemoApp_MVVM
 Map view, recording your voice 
### Images

Login             |  Registration   |  Map View             |  Map View Recording
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://raw.githubusercontent.com/tariqul000/TestMapDemoApp/main/preview/login.jpeg" alt="Login" width="200"/> | <img src="https://raw.githubusercontent.com/tariqul000/TestMapDemoApp/main/preview/registration.jpeg" alt="Registration" width="200"/> | <img src="https://raw.githubusercontent.com/tariqul000/TestMapDemoApp/main/preview/mapview.jpeg" alt="mapview" width="200"/>  |  <img src="https://raw.githubusercontent.com/tariqul000/TestMapDemoApp/main/preview/recordaudio.jpeg" alt="Hadis Chapter" width="200"/>


 A Test App Featuring MVVM,Hilt,Remote Mediator,Room,Navigation Component,Retrofit
# Tech stack & Open-source libraries
- 100% [Swift](https://www.swift.org/) based, [Cocoa Touch](https://cocoapods.org/) + [Googgle map](https://developers.google.com/maps/documentation) for map view.
  - SwiftUIð
  - Combine -  Combine is the reactive framework for handling events over time. I use here for audio play/pause handle, user data update, etc
  - Firebase/Auth - This end-to-end solution supports email and passowrd, phone auth, & mult-platform login.  
  - Firebase/Storage - Use for live database for resigtration, login. 
  - AVFoundation - Use for audio play/pause, AudioRecorder etc.
  - ViewModel - UI related data holder, lifecycle aware.
  - UserNotifications - To notify user when audio save.
  - Google Map - To display google map
  - Google Places - Track Places


  
# Loading Button Freamework 
ððððððððððððððððð

[CustomLoadingButton](https://github.com/tariqul000/CustomLoadingButton) - Use for animation when your loging button press. This is a open source library that develop by me 


# Architecture
- MVVM Architecture (View - ViewModel - Model)


# List of UI and Required Functions
  - Sign Up
  - Sign-in
  - Mapï¼Show current location with GPSï¼
  - Recordingï¼Record the voice from iPhone/iPad directlyï¼
  - After recording notify user
  - List of recorded list
  - Playï¼Play recorded audioï¼





