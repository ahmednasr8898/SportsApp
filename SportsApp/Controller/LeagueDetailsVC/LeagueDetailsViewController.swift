//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Nasr on 24/02/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var leagueDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        leagueDetailsTableView.delegate = self
        leagueDetailsTableView.dataSource = self
        
        leagueDetailsTableView.register(UpCommingTableViewCell.nib(), forCellReuseIdentifier: UpCommingTableViewCell.identifier)
    }
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    /*func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*var row = 0
        
        switch section {
        case 0:
            //array of upcoming
            row = 1
        case 1:
            //array of last event
            row = 1
        case 2:
            //array of teams
            row = 1
        default:
            row = 0
        }
        return row*/
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let upCommingCell = tableView.dequeueReusableCell(withIdentifier: UpCommingTableViewCell.identifier, for: indexPath) as! UpCommingTableViewCell
        
        return upCommingCell
        
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueDetailsCell", for: indexPath)
        let upCommingCell = tableView.dequeueReusableCell(withIdentifier: UpCommingTableViewCell.identifier, for: indexPath) as! UpCommingTableViewCell
        
        switch indexPath.section {
        case 0:
            //custom cell for upcoming data
            return upCommingCell
        case 1:
            //custom cell for last event data
            cell.textLabel?.text = "last event"
        case 2:
            //custom cell for taems data
            cell.textLabel?.text = "teams"
        default:
            cell.textLabel?.text = "teams"
        }
        return cell*/
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /*var title = ""
        
        switch section {
        case 0:
            title  = "UpComming"
        case 1:
            title  = "Last Event"
        case 2:
            title  = "Teams"
        default:
            title = ""
        }
        return title*/
        
        return "UpComming"
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 260
        /*var height: CGFloat = 100
        
        switch indexPath.section {
        case 0:
            height = 300
        default:
            height = 100
        }
        return height*/
    }
    
}

