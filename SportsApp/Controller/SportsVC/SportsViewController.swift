//
//  ViewController.swift
//  SportsApp
//
//  Created by Nasr on 22/02/2022.
//
import UIKit
import Alamofire
import SDWebImage

class SportsViewController: UIViewController{
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    var sporstArray: [Sport] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getAllSports()
    }
    
    func setupCollectionView(){
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        sportsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

extension SportsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sporstArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        if let sportImage = sporstArray[indexPath.row].strSportThumb, let sportName = sporstArray[indexPath.row].strSport {
            cell.sportsImageView.sd_setImage(with: URL(string: sportImage), placeholderImage: UIImage(named: "sports"))
            cell.sportNameLabel.text = sportName
            cell.contentView.layer.cornerRadius = 20
        }
        return cell
    }
}

extension SportsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        leagueVC.sportName = sporstArray[indexPath.row].strSport
        leagueVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(leagueVC, animated: true)
    }
}

extension SportsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45, height: self.view.frame.width * 0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 14, bottom: 20, right: 14)
    }
}

extension SportsViewController{
    func getAllSports(){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(_):
                print("error")
            case .success(_):
                guard let data = res.data else {
                    return
                }
                print("data: \(data)")
                do{
                    let json = try JSONDecoder().decode(SportsModel.self, from: data)
                    guard let sports = json.sports else {return}
                    self.sporstArray = sports
                }catch{
                    print("error when get All sporst")
                }
                DispatchQueue.main.async {
                    self.sportsCollectionView.reloadData()
                }
            }
        }
    }
}

//https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=Soccer
