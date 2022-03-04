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
    var arrOfLeagues = [LeagueDataModel]()
    var notFoundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotFoundImage()
        setupTabelView()
        self.getAllLeagues(strSport: self.sportName ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllFavoriteLeague()
    }
    
    func createNotFoundImage(){
        let image = UIImage(named: "resultnotfound")
        notFoundImage = UIImageView(image: image!)
        notFoundImage.center = self.view.center
        notFoundImage.frame = CGRect(x: self.view.frame.origin.x , y: 300, width: self.view.frame.width * 0.9, height: self.view.frame.width * 0.8)
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
        for league in arrOfLeagues{
            if league.idLeague == leagueID{
                complition(true)
            }
        }
    }
    
    func getAllFavoriteLeague(){
        CoreDataServices.shared.getAllFavoriteLeague { league, error in
            guard let leagues = league else {return}
            self.arrOfLeagues = leagues
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
                    print("No leagues")
                    self.view.addSubview(self.notFoundImage)
                    self.notFoundImage.isHidden = false
                    self.leagueTableView.isHidden = true
                    self.leagueTableView.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    return
                }
                self.notFoundImage.isHidden = true
                self.leagueTableView.isHidden = false
                self.leagueArray = leagues
                self.leagueTableView.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                self.leagueTableView.reloadData()
            }
        }
    }
}


