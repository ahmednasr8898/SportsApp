//
//  LeagueDetails+TableView.swift
//  SportsApp
//
//  Created by Nasr on 02/03/2022.
//

import Foundation
import UIKit

extension LeagueDetailsViewController{
    
    func setupTableView(){
        leagueDetailsTableView.delegate = self
        leagueDetailsTableView.dataSource = self
        leagueDetailsTableView.separatorStyle = .none
        
        leagueDetailsTableView.register(UpCommingTableViewCell.nib(), forCellReuseIdentifier: UpCommingTableViewCell.identifier)
        
        leagueDetailsTableView.register(LatestEventsTableViewCell.nib(), forCellReuseIdentifier: LatestEventsTableViewCell.identifier)
        
        leagueDetailsTableView.register(TeamsTableViewCell.nib(), forCellReuseIdentifier: TeamsTableViewCell.identifier)
    }
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        
        switch section {
        case 0:
            //Teams
            row = 1
        case 1:
            //Upcoming Events
            row = 1
        default:
            //Latest Events
            row = latestArray.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            
            let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.identifier, for: indexPath) as! TeamsTableViewCell
            // 5 trans to page from cell
            teamCell.selectedTeamDelagte = self
            return teamCell
        case 1:
            
            let  upCommingCell = tableView.dequeueReusableCell(withIdentifier: UpCommingTableViewCell.identifier, for: indexPath) as! UpCommingTableViewCell
            return upCommingCell
            
            
        default:
            let latestCell =  tableView.dequeueReusableCell(withIdentifier: LatestEventsTableViewCell.identifier, for: indexPath) as! LatestEventsTableViewCell
            
            let latest = latestArray[indexPath.row]
            if let homeTeam = latest.strHomeTeam, let awayTeam = latest.strAwayTeam, let matchPosterStr = latest.strThumb,
               let matchPosterUrl = URL(string: matchPosterStr), let matchDate = latest.dateEvent, let matchTime = latest.strTime, let homeScore = latest.intHomeScore, let awayScore = latest.intAwayScore {
                
                latestCell.homeTeamLabel.text = homeTeam
                latestCell.awayTeamLabel.text = awayTeam
                latestCell.matchPosterImageView.kf.indicatorType = .activity
                latestCell.matchPosterImageView.kf.setImage(with: matchPosterUrl)
                latestCell.DateMatchLabel.text = matchDate
                latestCell.timeMatchLabel.text = matchTime
                latestCell.homeScoreTeamLabel.text = homeScore
                latestCell.awayScoreTeamLabel.text = awayScore
            }
            else{
                latestCell.homeTeamLabel.text = ""
                latestCell.awayTeamLabel.text = ""
                latestCell.matchPosterImageView.image = UIImage(named: "notFound")
                latestCell.DateMatchLabel.text = ""
                latestCell.timeMatchLabel.text = ""
                latestCell.homeScoreTeamLabel.text = ""
                latestCell.awayScoreTeamLabel.text = ""
                latestCell.myView.layer.borderColor = UIColor.black.cgColor
                latestCell.myView.layer.borderWidth = 1
            }
            
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
            title  = "Teams"
        case 1:
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
            height = 140
        case 1:
            height = 260
        default:
            height = 160
        }
        return height
    }
}
