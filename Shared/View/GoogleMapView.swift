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

    var body: some View {
        ZStack(alignment: .bottom){
        GoogMapControllerRepresentable()
        
            
        HStack{
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
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
         .background(.gray)
            NavigationLink(destination: LoginView(viewModel: AuthViewModel()).navigationBarBackButtonHidden(true), isActive: $viewModel.goToLogin) { EmptyView().navigationBarTitle("")
                          .navigationBarHidden(true) }

            
        }
     
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView(viewModel: AuthViewModel())
    }
}


class GoogMapController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var zoomLevel: Float = 15.0
    let marker : GMSMarker = GMSMarker()


    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(14, maxZoom: 20)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false

        if let mylocation = mapView.myLocation {
          print("User's location: \(mylocation)")
        } else {
          print("User's location is unknown")
        }

//        marker.position = CLLocationCoordinate2D(latitude: 42.361145, longitude: -71.057083)
//        marker.title = "Boston"
//        marker.snippet = "USA"
//        marker.map = mapView

        // Add the map to the view, hide it until we&#39;ve got a location update.
        view.addSubview(mapView)
//        mapView.isHidden = true

    }

    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let location: CLLocation = locations.last!
      print("Location: \(location)")

      let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)

      if mapView.isHidden {
        mapView.isHidden = false
        mapView.camera = camera
      } else {
        mapView.animate(to: camera)
      }

    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      switch status {
      case .restricted:
        print("Location access was restricted.")
      case .denied:
        print("User denied access to location.")
        // Display the map using the default location.
        mapView.isHidden = false
      case .notDetermined:
        print("Location status not determined.")
      case .authorizedAlways: fallthrough
      case .authorizedWhenInUse:
        print("Location status is OK.")
      }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      locationManager.stopUpdatingLocation()
      print("Error: \(error)")
    }

}


struct GoogMapControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) -> GoogMapController {
        return GoogMapController()
    }

    func updateUIViewController(_ uiViewController: GoogMapController, context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) {

    }
}
