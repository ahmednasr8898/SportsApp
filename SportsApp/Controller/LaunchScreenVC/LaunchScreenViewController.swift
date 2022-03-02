//
//  LaunchScreenViewController.swift
//  SportsApp
//
//  Created by Nasr on 02/03/2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var mylabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mylabel.text = ""
        let title = "Sports App"
        var charIndex = 0.0
        
        for letter in title{
            
            Timer.scheduledTimer(withTimeInterval: 0.3 * charIndex, repeats: false) { timer in
                self.mylabel.text?.append(letter)
            }
           charIndex += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
            tabViewController.modalPresentationStyle = .fullScreen
            tabViewController.modalTransitionStyle = .flipHorizontal
            self.present(tabViewController, animated: true) {
                UIView.animate(withDuration: 0.1, delay: 0.5, options: .autoreverse, animations: {
                    self.view.alpha = 0
                }, completion: nil)
            }
        }
    }

}
