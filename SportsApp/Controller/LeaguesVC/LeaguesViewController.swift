//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Nasr on 23/02/2022.
//

import UIKit
import Alamofire

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leagueTableView: UITableView!
    var sportName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
    }
    
    func setupTabelView(){
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        leagueTableView.separatorStyle = .none
    }
}

extension LeaguesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueNameLabel.text = "Englanhs"
        cell.leagueImageView.image = UIImage(named: "Messi")
        
        
        //cell.containerView.backgroundColor = UIColor.white
        cell.containerView.layer.cornerRadius = 20
        cell.containerView.layer.shadowColor = UIColor.gray.cgColor
        cell.containerView.layer.shadowOffset = CGSize(width: 4,height: 4)
        cell.containerView.layer.shadowRadius = 5
        cell.containerView.layer.shadowOpacity = 0.3

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LeaguesViewController: UITableViewDelegate{
}

//https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=Soccer
