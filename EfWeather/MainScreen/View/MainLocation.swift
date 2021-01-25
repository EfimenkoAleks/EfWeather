//
//  MainLocation.swift
//  EfWeather
//
//  Created by user on 17.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import CoreLocation

//extension MainViewController: CLLocationManagerDelegate {
//
//    func createLocation() {
//        let authStatus = CLLocationManager.authorizationStatus()
//         if authStatus == .notDetermined {
//             locationManager.requestWhenInUseAuthorization()
//         }
//
////         if authStatus == .denied || authStatus == .restricted {
////             // add any alert or inform the user to to enable location services
////         }
//
//        // here you can call the start location function
//        startLocationManager()
//    }
//
//    func startLocationManager() {
//        // always good habit to check if locationServicesEnabled
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func stopLocationManager() {
//       locationManager.stopUpdatingLocation()
//       locationManager.delegate = nil
//    }
//
////MARK: - location delegate methods
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation :CLLocation = locations[0] as CLLocation
//
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")
//
//        self.viewModel.updateLocation(lat: userLocation.coordinate.latitude.description, lon: userLocation.coordinate.longitude.description)
//
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
//            if (error != nil){
//                print("error in reverseGeocode")
//            }
//            let placemark = placemarks! as [CLPlacemark]
//            if placemark.count>0{
//                let placemark = placemarks![0]
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
//            }
//        }
//
//        CLGeocoder().reverseGeocodeLocation(userLocation, preferredLocale: Locale.init(identifier: "ru_RUS"), completionHandler: {(placemarks, error) -> Void in
//            print(userLocation)
//
//            if error != nil {
//                print("Reverse geocoder failed with error" + error!.localizedDescription)
//                return
//            }
//
//            if placemarks!.count > 0 {
//                let pm = placemarks![0]
//                print(pm.administrativeArea!, pm.locality!)
//            }
//            else {
//                print("Problem with the data received from geocoder")
//            }
//        })
//
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error \(error)")
//        locationManager.stopUpdatingLocation()
//        locationManager.delegate = nil
//        self.viewModel.updateLocation(lat: "37.3317", lon: "79.0302")// для запуска на симуляторе
//
//        if let clErr = error as? CLError {
//            switch clErr {
//            case CLError.locationUnknown:
//                print("location unknown")
//            case CLError.denied:
//                print("denied")
//            default:
//                print("other Core Location error")
//            }
//        } else {
//            print("other error:", error.localizedDescription)
//        }
//    }
//}
