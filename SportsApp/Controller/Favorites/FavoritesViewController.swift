//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//
import UIKit
import Kingfisher

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTabelView: UITableView!
    @IBOutlet weak var noResulImageView: UIImageView!
    var arrOfLeagues = [LeagueDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllFavoriteLeague()
        checkFavoriteIsEmpty()
    }
}

extension FavoritesViewController{
    func getAllFavoriteLeague(){
        CoreDataServices.shared.getAllFavoriteLeague { leagues, error in
            guard let leagues = leagues else {return}
            self.arrOfLeagues = leagues
            self.checkFavoriteIsEmpty()
            DispatchQueue.main.async {
                self.favoritesTabelView.reloadData()
            }
        }
        
    }
}

extension FavoritesViewController{
    func checkFavoriteIsEmpty(){
        if arrOfLeagues.isEmpty{
            print("fav is empty")
            favoritesTabelView.isHidden = true
            noResulImageView.isHidden = false
        }else{
            favoritesTabelView.isHidden = false
            noResulImageView.isHidden = true
        }
    }
}

