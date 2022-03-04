//
//  LeagueVC+TableView.swift
//  SportsApp
//
//  Created by Nasr on 02/03/2022.
//

import Foundation
import UIKit
import SkeletonView

extension LeaguesViewController{
    func setupTabelView(){
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        leagueTableView.separatorStyle = .none
        leagueTableView.estimatedRowHeight = 120
    }
}

extension LeaguesViewController: SkeletonTableViewDataSource{
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueArray.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return LeagueTableViewCell.identifier
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.identifier, for: indexPath) as! LeagueTableViewCell
      
        let league = leagueArray[leagueArray.count - indexPath.row - 1]
        if !leagueArray.isEmpty, let leagueName = league.strLeague, let leagueImageStr = league.strBadge, let leagueImageUrl = URL(string: leagueImageStr) {
            
            cell.leagueNameLabel.text = leagueName
            cell.leagueImageView.kf.indicatorType = .activity
            cell.leagueImageView.kf.setImage(with: leagueImageUrl)
            cell.youtubeButton.setImage(UIImage(named: "youtube"), for: .normal)
            cell.containerView.backgroundColor = UIColor.white
            cell.containerView.layer.cornerRadius = 20
            cell.containerView.layer.shadowColor = UIColor.gray.cgColor
            cell.containerView.layer.shadowOffset = CGSize(width: 4,height: 4)
            cell.containerView.layer.shadowRadius = 5
            cell.containerView.layer.shadowOpacity = 0.3
            
            cell.youtubeButton.addAction(UIAction(handler: { _ in
                if let youTubeStr = self.leagueArray[self.leagueArray.count - indexPath.row - 1].strYoutube{
                    UIApplication.shared.open(URL(string: "https://\(youTubeStr)")! as URL, options: [:], completionHandler: nil)
                }
            }), for: .touchUpInside)
        }
        return cell
    }
}

extension LeaguesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = leagueArray[leagueArray.count - indexPath.row - 1]
        guard let leagueID = league.idLeague, let leagueName = league.strLeague else {return}
        self.goToLeagueDetailsVC(selectedLeague: league, leagueID: leagueID, leagueName: leagueName)
    }
}
