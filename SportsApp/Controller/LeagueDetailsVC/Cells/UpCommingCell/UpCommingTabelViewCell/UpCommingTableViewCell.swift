//
//  UpCommingTableViewCell.swift
//  SportsApp
//
//  Created by Nasr on 24/02/2022.
//

import UIKit
import Alamofire
import Kingfisher

class UpCommingTableViewCell: UITableViewCell {
   
    @IBOutlet weak var upCommingCollectionView: UICollectionView!
    static var identifier = "UpCommingTableViewCell"
    var upCommingEventArray: [Event] = []
    
    static func nib ()->UINib{
        return UINib(nibName: "UpCommingTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionView()
        getAllUpCommingEvents()
    }
    
    func setUpCollectionView(){
        upCommingCollectionView.register(UpCommingCollectionViewCell.nib(), forCellWithReuseIdentifier: UpCommingCollectionViewCell.idenifier)
        upCommingCollectionView.delegate  = self
        upCommingCollectionView.dataSource = self
    }
}

extension UpCommingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upCommingEventArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpCommingCollectionViewCell.idenifier, for: indexPath) as! UpCommingCollectionViewCell
        
        let upCommingItem = upCommingEventArray[indexPath.row]
        if let homeTeam = upCommingItem.strHomeTeam, let awayTeam = upCommingItem.strAwayTeam, let matchPosterStr = upCommingItem.strThumb, let matchPosterUrl = URL(string: matchPosterStr), let matchDate = upCommingItem.dateEvent, let matchTime = upCommingItem.strTime {
            
            cell.homeTeamNameLabel.text = homeTeam
            cell.awayTeamNameLabel.text = awayTeam
            cell.posterImageView.kf.indicatorType = .activity
            cell.posterImageView.kf.setImage(with: matchPosterUrl)
            cell.matchDateLabel.text = matchDate
            cell.matchTimeLabel.text = matchTime
            
            cell.myView.layer.cornerRadius = 30
            cell.posterImageView.layer.cornerRadius = 30
            cell.myView.layer.borderColor = UIColor.red.cgColor
            cell.myView.layer.borderWidth = 1
            cell.myView.layer.shadowColor = UIColor.gray.cgColor
            cell.myView.layer.shadowOffset = CGSize(width: 4,height: 4)
            cell.myView.layer.shadowRadius = 5
            cell.myView.layer.shadowOpacity = 0.6
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 260)
    }
}

extension UpCommingTableViewCell{
    func getAllUpCommingEvents(){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38&s=2021-2022") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(_):
                print("error")
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(UpCommingModel.self, from: data)
                    guard let evnets = json.events else {return}
                    self.upCommingEventArray = evnets
                }catch{
                    print("error when get All UpComming Events")
                }
                DispatchQueue.main.async {
                    self.upCommingCollectionView.reloadData()
                }
            }
        }
    }
}
