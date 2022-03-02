//
//  SportsVC+CollectionView.swift
//  SportsApp
//
//  Created by Nasr on 02/03/2022.
//

import Foundation
import UIKit
 
extension SportsViewController{
    
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
        let sports = sporstArray[indexPath.row]
        if let sportImageStr = sports.strSportThumb,let sportImageUrl = URL(string: sportImageStr), let sportName = sports.strSport {
            cell.sportsImageView.kf.indicatorType = .activity
            cell.sportsImageView.kf.setImage(with: sportImageUrl, placeholder: UIImage(named: "sports"))
            cell.sportNameLabel.text = sportName
            cell.myView.backgroundColor = UIColor.white
            cell.myView.layer.cornerRadius = 25
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let transEffect = CATransform3DTranslate(CATransform3DIdentity, -800, 100, 0)
        cell.layer.transform = transEffect
        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
        }
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
