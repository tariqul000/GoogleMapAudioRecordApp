//
//  GoogMapController.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 14/11/21.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Foundation

class GoogMapController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var mapViewFinal: GMSMapView!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var zoomLevel: Float = 15.0


    @Binding var isClicked : Bool
    init(isClicked: Binding<Bool>) {
            _isClicked = isClicked
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapViewFinal = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapViewFinal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapViewFinal.isMyLocationEnabled = true
        mapViewFinal.setMinZoom(14, maxZoom: 20)
        mapViewFinal.settings.compassButton = true
        mapViewFinal.isMyLocationEnabled = true
        mapViewFinal.settings.myLocationButton = true
        mapViewFinal.settings.scrollGestures = true
        mapViewFinal.settings.zoomGestures = true
        mapViewFinal.settings.rotateGestures = true
        mapViewFinal.settings.tiltGestures = true
        mapViewFinal.isIndoorEnabled = false
        mapViewFinal.delegate = self
        
        if let mylocation = mapViewFinal.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        
        
        
        // Add the map to the view, hide it until we&#39;ve got a location update.
        view.addSubview(mapViewFinal)
        //        mapView.isHidden = true
        
    }
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        if mapViewFinal.isHidden {
            mapViewFinal.isHidden = false
            mapViewFinal.camera = camera
        } else {
            mapViewFinal.animate(to: camera)
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
            mapViewFinal.isHidden = false
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
    
    // on tap test
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("tapped on marker")
        
        if marker.title == "Me"{
            print("handle specific marker")
            self.isClicked.toggle()

            
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print(overlay)
        
        print("tap working didTap")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {

        NotificationHelper.lat = String(coordinate.latitude)
        NotificationHelper.long = String(coordinate.longitude)

        mapViewFinal.clear()
        let marker = GMSMarker(position: coordinate)
        marker.title = "Me"
        marker.map = mapViewFinal
        
     

       // print()
        
        print("tap working")
    }
    
    
}


struct GoogMapControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var isClicked: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) -> GoogMapController {
        return GoogMapController(isClicked: $isClicked)
    }
    
    func updateUIViewController(_ uiViewController: GoogMapController, context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) {
        
    }
}
