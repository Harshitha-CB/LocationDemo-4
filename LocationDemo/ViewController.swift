//
//  ViewController.swift
//  LocationDemo
//
//  Created by Shridevi Sawant on 23/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoL: UILabel!
    
    @IBOutlet weak var stopB: UIButton!
    @IBOutlet weak var startB: UIButton!
    
    
    let locUtility = LocationUtility.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopB.isEnabled = false
        
    }

    @IBAction func stopClicked(_ sender: Any) {
        let isStopped = locUtility.stopTracking()
        
        if isStopped {
            // disable 'Stop' button and enable 'Start'
            stopB.isEnabled = false
            startB.isEnabled = true
        } else {
            // show alert for problem
            showAlert(message: "Check the permission", title: "Problem Stopping tracking:")
        }
    }
    
    @IBAction func showClicked(_ sender: Any) {
        
        if let curLoc = locUtility.currentLocation {
            var distance :Double = 0
            
            if let fLoc = locUtility.firstLocation {
                
                distance = fLoc.distance(from: curLoc)
            }
            
            GeocodingUtility.instance.getAddressFromCoord(loc: curLoc) { addr in
                
                self.infoL.text = """
                Current Location: \(curLoc.coordinate.latitude), \(curLoc.coordinate.longitude),
                Address: \(addr),
                Total Distance: \(distance) meters
                """
            }
            
            
        }
        else {
            infoL.text = "Location data not available"
        }
    }
    
    @IBAction func startClicked(_ sender: Any) {
        let isStarted = locUtility.startTracking()
        
        if isStarted {
            // disable 'Start' button and 'stop' button enabled
            stopB.isEnabled = true
            startB.isEnabled = false
        }
        else {
            // show alert for problem
            showAlert(message: "Check the permission", title: "Problem Starting tracking:")
        }
    }
    
    
    @IBAction func mapClicked(_ sender: Any) {
        
        /*
         
         1. launching existing Map, pass location to be shown
         // URL based navigation
         
         url = "mailto:shridevi.hiroji@gmail.com" // email
         url = "smsto:98232323" // messaging
         url = "tel:123454564" // phone to make call
         */
        
        if let curLoc = locUtility.currentLocation {
        
            let mapUrl = "http://maps.apple.com/?ll=\(curLoc.coordinate.latitude),\(curLoc.coordinate.longitude)"
            
           
            
            if let url = URL(string: mapUrl) {
                
                if UIApplication.shared.canOpenURL(url) {
                
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    
                }else {
                    showAlert(message: "Pls install App", title: "No App to make call")
                }
            }
        }

         
        /*
         2. create custom map - MKMapView
         
         */
    }
    
}

