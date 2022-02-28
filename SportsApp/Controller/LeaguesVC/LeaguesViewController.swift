//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Nasr on 23/02/2022.
//

import UIKit
import Alamofire
import SkeletonView
import Kingfisher

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leagueTableView: UITableView!
    var sportName: String?
    var leagueArray: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
        callAllLeagueMethod()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        leagueTableView.isSkeletonable = true
        leagueTableView.showAnimatedGradientSkeleton()
    }
    
    func setupTabelView(){
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        leagueTableView.separatorStyle = .none
        leagueTableView.estimatedRowHeight = 120
    }
}

extension LeaguesViewController{
    func callAllLeagueMethod(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getAllLeagues(strSport: self.sportName ?? "")
            self.leagueTableView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.leagueTableView.reloadData()
        }
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
      
        if !leagueArray.isEmpty, let leagueName = leagueArray[indexPath.row].strLeague, let leagueImageStr = leagueArray[indexPath.row].strBadge, let leagueImageUrl = URL(string: leagueImageStr) {
            
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
                if let youTubeStr = self.leagueArray[indexPath.row].strYoutube{
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
        guard let leagueID = leagueArray[indexPath.row].idLeague else {return}
        self.goToLeagueDetailsVC(leagueID: leagueID)
        
    }
}

extension LeaguesViewController{
    func goToLeagueDetailsVC(leagueID: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        //move league ID to leagueDetails
        Helper.shared.setLeagueID(leagueID: leagueID)
        self.present(vc, animated: true, completion: nil)
    }
}

extension LeaguesViewController{
    func getAllLeagues(strSport: String){
        Networking.shared.getAllLeagues(strSport: strSport) { leagueModel, error in
            guard let leagues = leagueModel?.countrys, error == nil else {return}
            self.leagueArray = leagues
            self.leagueTableView.reloadData()
        }
    }
}
