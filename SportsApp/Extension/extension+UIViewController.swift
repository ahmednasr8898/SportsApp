//
//  extension+UIViewController.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func showConfirmAlert(title: String, message: String, complition: @escaping (Bool)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmBtn = UIAlertAction(title: "Confirm", style: .default) { _ in
            complition(true)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(confirmBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
    }
}
