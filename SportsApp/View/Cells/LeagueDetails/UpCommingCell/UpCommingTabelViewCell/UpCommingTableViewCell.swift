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
    var upCommingEventArray: [Event] = []
    
    static var identifier = "UpCommingTableViewCell"
    static func nib ()->UINib{
        return UINib(nibName: "UpCommingTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionView()
        Helper.shared.getLeagueID { leagueID in
            self.getAllUpCommingEvents(leagueID: leagueID)
        }
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
        }else{
            cell.homeTeamNameLabel.text = ""
            cell.awayTeamNameLabel.text = ""
            cell.posterImageView.image = UIImage(named: "notFound")
            cell.matchDateLabel.text = ""
            cell.matchTimeLabel.text = ""
        }
        
        cell.myView.layer.cornerRadius = 30
        cell.posterImageView.layer.cornerRadius = 30
        cell.myView.layer.borderColor = UIColor.black.cgColor
        cell.myView.layer.borderWidth = 1
        cell.myView.layer.shadowColor = UIColor.gray.cgColor
        cell.myView.layer.shadowOffset = CGSize(width: 4,height: 4)
        cell.myView.layer.shadowRadius = 5
        cell.myView.layer.shadowOpacity = 0.6
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 260)
    }
}

extension UpCommingTableViewCell{
    func getAllUpCommingEvents(leagueID: String){
        Networking.shared.getAllUpCommingEvents(leagueID: leagueID) { upCommingModel, error in
            guard let upComming = upCommingModel?.events, error == nil else {return}
            self.upCommingEventArray = upComming
            self.upCommingCollectionView.reloadData()
        }
    }
}
