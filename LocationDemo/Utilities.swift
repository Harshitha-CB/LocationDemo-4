//
//  Utilities.swift
//  LocationDemo
//
//  Created by Shridevi Sawant on 23/05/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String, title: String){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: false, completion: nil)
    }
}
