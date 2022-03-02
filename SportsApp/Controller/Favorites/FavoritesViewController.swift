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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var leagues = [LeagueDataModel]()
    
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
        do{
            self.leagues = try self.context.fetch(LeagueDataModel.fetchRequest())
            checkFavoriteIsEmpty()
            DispatchQueue.main.async {
                self.favoritesTabelView.reloadData()
            }
        }catch{
            print("Error in getAllFavoriteLeague function: ", error.localizedDescription)
        }
    }
}

extension FavoritesViewController{
    func checkFavoriteIsEmpty(){
        if leagues.isEmpty{
            print("fav is empty")
            favoritesTabelView.isHidden = true
            noResulImageView.isHidden = false
        }else{
            favoritesTabelView.isHidden = false
            noResulImageView.isHidden = true
        }
    }
}

extension FavoritesViewController{
    func deletedSelectedItem(row: Int){
        let selectedLeague = leagues[row]
        self.context.delete(selectedLeague)
        do{
            //3- save change
            try self.context.save()
        }catch{
            print("Error when delete league: ", error.localizedDescription)
        }
        self.getAllFavoriteLeague()
    }
}
