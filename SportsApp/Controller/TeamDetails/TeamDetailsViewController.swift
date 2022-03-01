//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var selectedTeam: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let team = selectedTeam else {return}
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
