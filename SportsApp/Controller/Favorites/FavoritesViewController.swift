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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var leagues = [LeagueDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllFavoriteLeague()
    }
    
    func setupTabelView(){
        favoritesTabelView.delegate = self
        favoritesTabelView.dataSource = self
        favoritesTabelView.separatorStyle = .none
        favoritesTabelView.estimatedRowHeight = 120
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoritesTableViewCell
        let league = leagues[indexPath.row]
        if let leagueName = league.strLeague, let leagueImageStr = league.strBadge{
            cell.leagueNameLabel.text = leagueName
            cell.leagueImageView.kf.indicatorType = .activity
            cell.leagueImageView.kf.setImage(with: URL(string: leagueImageStr))
            cell.youTubeButton.setImage(UIImage(named: "youtube"), for: .normal)
        }
        
        cell.myView.backgroundColor = UIColor.white
        cell.myView.layer.cornerRadius = 20
        cell.myView.layer.shadowColor = UIColor.gray.cgColor
        cell.myView.layer.shadowOffset = CGSize(width: 4,height: 4)
        cell.myView.layer.shadowRadius = 5
        cell.myView.layer.shadowOpacity = 0.3
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.showConfirmAlert(title: "Delete this league!!!", message: "Are you sure to delete this league!!!") { confimDeleted in
                if confimDeleted{
                    self.deletedSelectedItem(row: indexPath.row)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        guard let leagueID = leagues[indexPath.row].idLeague, let leagueName = leagues[indexPath.row].strLeague else {return}
        Helper.shared.setLeagueID(leagueID: leagueID)
        Helper.shared.setLeagueName(leagueName: leagueName)
        vc.leagueIsFoundInFavorite = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoritesViewController{
    func getAllFavoriteLeague(){
        do{
            self.leagues = try self.context.fetch(LeagueDataModel.fetchRequest())
            DispatchQueue.main.async {
                self.favoritesTabelView.reloadData()
            }
        }catch{
            print("Error in getAllFavoriteLeague function: ", error.localizedDescription)
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
