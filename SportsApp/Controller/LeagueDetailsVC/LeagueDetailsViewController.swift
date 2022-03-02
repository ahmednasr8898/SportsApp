//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Nasr on 24/02/2022.
//
import UIKit
import Alamofire
import Kingfisher
import CoreData

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var leagueDetailsTableView: UITableView!
    var latestArray: [Event] = []
    var selectedLeague: Country?
    var leagueIsFoundInFavorite: Bool?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    var leagues = [LeagueDataModel]()
    var leagueID: String?

    var notFoundImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //createNotFound()
        setupTableView()
        getLeagueID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllFavoriteLeague()
        checkLeagueIsFoundInFavorite()
        setLeagueID()
    }

    @IBAction func didPressedOnFavBtn(_ sender: UIBarButtonItem) {
        selectedFavoritBtn(sender: sender)
    }
}

extension LeagueDetailsViewController{
    func createNotFound(){
        let image = UIImage(named: "no-internet-connection")
        notFoundImage = UIImageView(image: image!)
        notFoundImage.center = self.view.center
        view.addSubview(notFoundImage)
    }
    
}

extension LeagueDetailsViewController{
    func getAllLatestEvents(leagueID: String){
        Networking.shared.getAllLatestEvents(leagueID: leagueID) { latestEventsModel, error in
            guard let latestEvents = latestEventsModel?.events, error == nil else {
                self.showToastMessege(message: "No Latest Events")
                print("No getAllLatestEvents")
                return
            }
            self.latestArray = latestEvents
            self.leagueDetailsTableView.reloadData()
        }
    }
}

// 4 trans to page from cell
extension LeagueDetailsViewController: selectedTeamProtocol{
    func onClickTeam(team: Team) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        vc.selectedTeam = team
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

