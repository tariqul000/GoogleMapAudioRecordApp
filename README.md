# TestMapDemoApp_MVVM
Map view, recording your voice 
 A Test App Featuring MVVM,Hilt,Remote Mediator,Room,Navigation Component,Retrofit
# Tech stack & Open-source libraries
- 100% [Swift](https://www.swift.org/) based, [Cocoa Touch](https://cocoapods.org/) + [Googgle map](https://developers.google.com/maps/documentation) for map view.
  - SwiftUI🚀
  - Combine -  Combine is the reactive framework for handling events over time. I use here for audio play/pause handle, user data update, etc
  - Firebase/Auth - This end-to-end solution supports email and passowrd, phone auth, & mult-platform login.  
  - Firebase/Storage - Use for live database for resigtration, login. 
  - AVFoundation - Use for audio play/pause, AudioRecorder etc.
  - ViewModel - UI related data holder, lifecycle aware.
  - UserNotifications - To notify user when audio save.
  - Google Map - To display google map
  - Google Places - Track Places


## Architecture
- MVVM Architecture (View - ViewModel - Model)


# List of UI and Required Functions
  - Sign Up
  - Sign-in
  - Map（Show current location with GPS）
  - Recording（Record the voice from iPhone/iPad directly）
  - After recording notify user
  - List of recorded list
  - Play（Play recorded audio）





