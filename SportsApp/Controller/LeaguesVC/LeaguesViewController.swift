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
import CoreData

class LeaguesViewController: UIViewController {

    @IBOutlet weak var leagueTableView: UITableView!
    var sportName: String?
    var leagueArray: [Country] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var leagues = [LeagueDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
        self.getAllLeagues(strSport: self.sportName ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllFavoriteLeague()
    }
    
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
        guard let leagueID = leagueArray[indexPath.row].idLeague, let leagueName = leagueArray[indexPath.row].strLeague else {return}
        self.goToLeagueDetailsVC(selectedLeague: leagueArray[indexPath.row], leagueID: leagueID, leagueName: leagueName)
    }
}

extension LeaguesViewController{
    func goToLeagueDetailsVC(selectedLeague: Country ,leagueID: String, leagueName: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        //move league ID to leagueDetails
        Helper.shared.setLeagueID(leagueID: leagueID)
        Helper.shared.setLeagueName(leagueName: leagueName)
        vc.selectedLeague = selectedLeague
        //check is league found in favorite or not
        self.checkIsLeagueFoundInFavoriteOrNot(leagueID: leagueID) { isFoundInFavorite in
            if isFoundInFavorite{
                vc.leagueIsFoundInFavorite = true
            }else{
                vc.leagueIsFoundInFavorite = false
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LeaguesViewController{
    func checkIsLeagueFoundInFavoriteOrNot(leagueID: String, complition: @escaping (Bool)->Void){
        for league in leagues{
            if league.idLeague == leagueID{
                complition(true)
            }
        }
    }
    
    func getAllFavoriteLeague(){
        do{
            self.leagues = try self.context.fetch(LeagueDataModel.fetchRequest())
        }catch{
            print("Error in getAllFavoriteLeague function: ", error.localizedDescription)
        }
    }
}

extension LeaguesViewController{
    func getAllLeagues(strSport: String){
        leagueTableView.isSkeletonable = true
        leagueTableView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Networking.shared.getAllLeagues(strSport: strSport) { leagueModel, error in
                guard let leagues = leagueModel?.countrys, error == nil else {
                    self.leagueTableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    return
                }
                self.leagueArray = leagues
                self.leagueTableView.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                self.leagueTableView.reloadData()
            }
        }
    }
}


