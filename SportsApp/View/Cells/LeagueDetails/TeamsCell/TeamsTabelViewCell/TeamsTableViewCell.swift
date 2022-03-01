//
//  TeamsTableViewCell.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

import UIKit
import Kingfisher

class TeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var teamCollectionView: UICollectionView!
    var teamArray: [Team] = []
    
    static var identifier = "TeamsTableViewCell"
    static func nib ()->UINib{
        return UINib(nibName: "TeamsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
        self.getAllTeams()
    }
    
    func setupCollectionView(){
        teamCollectionView.register(TeamCollectionViewCell.nib(), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        teamCollectionView.showsVerticalScrollIndicator = false
        teamCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension TeamsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier, for: indexPath) as! TeamCollectionViewCell
        
        let team = teamArray[indexPath.row]
        if let teamName = team.strTeam, let teamImageStr = team.strTeamBadge, let teamImageUrl = URL(string: teamImageStr){
            cell.teamNameLabel.text = teamName
            cell.teamImageView.kf.indicatorType = .activity
            cell.teamImageView.kf.setImage(with: teamImageUrl)
        }
        cell.myView.layer.cornerRadius = 50
        cell.myView.layer.borderColor = UIColor.yellow.cgColor
        cell.myView.layer.borderWidth = 3
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: teamCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
}

extension TeamsTableViewCell{
    func getAllTeams(){
        Networking.shared.getAllTeams { teamModel, error in
            guard let teams = teamModel?.teams, error == nil else {return}
            self.teamArray = teams
            self.teamCollectionView.reloadData()
        }
    }
}
