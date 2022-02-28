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
        leagueDetailsTableView.separatorStyle = .none
        
        leagueDetailsTableView.register(UpCommingTableViewCell.nib(), forCellReuseIdentifier: UpCommingTableViewCell.identifier)
        
        leagueDetailsTableView.register(LatestEventsTableViewCell.nib(), forCellReuseIdentifier: LatestEventsTableViewCell.identifier)
    }
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        
        switch section {
        case 0:
            //array of upcoming
            row = 1
        default:
            //array of teams
            row = 20
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let  upCommingCell = tableView.dequeueReusableCell(withIdentifier: UpCommingTableViewCell.identifier, for: indexPath) as! UpCommingTableViewCell
            return upCommingCell
        default:
            let latestCell =  tableView.dequeueReusableCell(withIdentifier: LatestEventsTableViewCell.identifier, for: indexPath) as! LatestEventsTableViewCell
            
            latestCell.matchPosterImageView.layer.cornerRadius = 30
            let transEffect = CATransform3DTranslate(CATransform3DIdentity, 0, -100, -800)
            latestCell.layer.transform = transEffect
            LatestEventsTableViewCell.animate(withDuration: 0.3) {
                latestCell.layer.transform = CATransform3DIdentity
            }
            return latestCell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        var title = ""
        switch section {
        case 0:
            title  = "UpComming"
        default:
            title  = "Last Event"
        }
        return title
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0:
            height = 260
        default:
            height = 160
        }
        return height
    }
}

