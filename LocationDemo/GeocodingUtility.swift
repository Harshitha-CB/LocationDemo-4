//
//  GeocodingUtility.swift
//  LocationDemo
//
//  Created by Shridevi Sawant on 23/05/22.
//

import Foundation
import CoreLocation

// Single Geocoder - one conversion

struct GeocodingUtility {
    
    private init() {
        
    }
    
    static let instance = GeocodingUtility()
    
    func getAddressFromCoord(loc : CLLocation, completion: @escaping (String) -> Void ) {
        // reverse geocoding
        let gc = CLGeocoder()
        
        gc.reverseGeocodeLocation(loc) { places, err in
            
            if err == nil {
                if let placeList = places {
                    let addr = placeList[0]
                    let strAddr = """
                        \(addr.name ?? ""),
                        \(addr.locality ?? ""),
                        \(addr.administrativeArea ?? "")
                        \(addr.country ?? ""),
                        \(addr.postalCode ?? "")
                        """
                    
                    completion(strAddr)
                    
                }
                else {
                    print("ERROR: Could not reverse geocode")
                }
                
            }
            else {
                print("ERROR: reverse geocoding \(err?.localizedDescription ?? "" )")
            }
        }
        
       
    }
    
    func getCoordFromAddress(address: String, completion: @escaping (CLLocation?) -> Void) {
        // forward geocoding
        
        let gc = CLGeocoder()
        
        gc.geocodeAddressString(address) { places, err in
            
            if err == nil {
                // no error
                
                if let placeList = places {
                    
                    let place = placeList[0]
                    if let loc = place.location {
                        completion(loc)
                    }
                }
            }
            else {
                print("ERROR: Forward geocoding failed..\(err?.localizedDescription ?? "")")
                completion(nil)
            }
        }
    }
}
