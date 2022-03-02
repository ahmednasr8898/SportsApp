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

extension UIViewController{
    func showToastMessege(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height-100, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 20)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
