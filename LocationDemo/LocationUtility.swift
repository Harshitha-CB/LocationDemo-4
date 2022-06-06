//
//  LocationUtility.swift
//  LocationDemo
//
//  Created by Shridevi Sawant on 23/05/22.
//

import Foundation
import CoreLocation

// singleton-pattern
class LocationUtility : NSObject, CLLocationManagerDelegate {
    
    let locationManager : CLLocationManager
    var isPermissionGranted = false
    var currentLocation : CLLocation?
    var firstLocation: CLLocation?
    
    private override init() {
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    static let instance = LocationUtility()
    
    func startTracking() -> Bool {
        if isPermissionGranted {
            locationManager.startUpdatingLocation()
            print("Tracking started")
            return true
        }
        
        return false
    }
    
    func stopTracking() -> Bool {
        if isPermissionGranted {
            locationManager.stopUpdatingLocation()
            print("Tracking stopped")
            return true
        }
        
        return false
    }
    
    // from delegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Permission granted: When in Use")
            isPermissionGranted = true
        case .authorizedAlways:
            print("Permission granted: Always")
            isPermissionGranted = true
        case .denied:
            print("Permission denied")
        case .notDetermined:
            print("Permission cannot be determined")
        default:
            print("Unknown..")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // executed when user's location is changed
        
        if let latestLoc = locations.last {
            currentLocation = latestLoc
            
            if firstLocation == nil {
                print("First location")
                firstLocation = latestLoc
            }
            
            print("Updated Latt: \(latestLoc.coordinate.latitude), Longi: \(latestLoc.coordinate.longitude)")
        }
    }
    
}
