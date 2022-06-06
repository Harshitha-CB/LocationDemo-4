//
//  GeoCodingVC.swift
//  LocationDemo
//
//  Created by Shridevi Sawant on 23/05/22.
//

import UIKit
import CoreLocation

class GeoCodingVC: UIViewController {

    @IBOutlet weak var infoL: UILabel!
    @IBOutlet weak var addressT: UITextField!
    @IBOutlet weak var longiT: UITextField!
    @IBOutlet weak var lattT: UITextField!
    
    let gcUtility = GeocodingUtility.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func convertClicked(_ sender: Any) {
        
        let lattS = lattT.text ?? ""
        let longiS = longiT.text ?? ""
        let address = addressT.text ?? ""
        
        if !lattS.isEmpty && !longiS.isEmpty {
            // convert latt/long to address - reverse geocoding
            print("Reverse geocoding \(lattS), \(longiS)")
            
            let latt = Double(lattS) ?? 0.0
            let longi = Double(longiS) ?? 0.0
            
            let toConvert = CLLocation(latitude: latt, longitude: longi)
            
            gcUtility.getAddressFromCoord(loc: toConvert) { convertedAddr in
                
                self.infoL.text = "Street Address: \(convertedAddr)"
            }
        }
        else if !address.isEmpty {
            // convert address to lat/long - forward geocoding
            print("Forward geocoding \(address)")
            gcUtility.getCoordFromAddress(address: address) { loc in
                
                if let convertedLoc = loc {
                    self.infoL.text = "Geo Coordinates: \(convertedLoc.coordinate.latitude), \(convertedLoc.coordinate.longitude)"
                }
                else {
                    self.showAlert(message: "Please check address", title: "Conversion failed")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
