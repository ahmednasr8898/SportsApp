//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {
    
    var selectedTeam: Team?
    @IBOutlet weak var stduimTeamImageView: UIImageView!
    @IBOutlet weak var teamImgaView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var studimNameLabel: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var myViewOne: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tshirtImageView: UIImageView!
    @IBOutlet weak var myViewTwo: UIView!
    @IBOutlet weak var instaButton: UIButton!
    var notFoundImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNotFoundImage()
        setupDesign()
        setData()
    }
    
    func setupDesign(){
        myViewOne.layer.cornerRadius = 40
        myViewOne.layer.shadowColor = UIColor.gray.cgColor
        myViewOne.layer.shadowOffset = CGSize(width: 8, height: 8)
        myViewOne.layer.shadowRadius = 5
        myViewOne.layer.shadowOpacity = 0.4
        
        myViewTwo.layer.cornerRadius = 10
        myViewTwo.layer.shadowColor = UIColor.gray.cgColor
        myViewTwo.layer.shadowOffset = CGSize(width: 6, height: 6)
        myViewTwo.layer.shadowRadius = 5
        myViewTwo.layer.shadowOpacity = 0.3
    }
    
    func setData(){
        guard let team = selectedTeam, let teamImageStr = team.strTeamBadge, let teamImageUrl = URL(string: teamImageStr),
              let tshirtImageStr = team.strTeamJersey, let tshirtImageUrl = URL(string: tshirtImageStr) else {
                  checkIsTeamNotFound()
                  print("no team details")
                  return
              }
        
        teamNameLabel.text = team.strTeam
        studimNameLabel.text = team.strStadium
        teamImgaView.kf.setImage(with: teamImageUrl)
        leagueName.text = team.strLeague
        yearLabel.text = team.intFormedYear
        tshirtImageView.kf.setImage(with: tshirtImageUrl)
        
    }
    func createNotFoundImage(){
        let image = UIImage(named: "resultnotfound")
        notFoundImage = UIImageView(image: image!)
        notFoundImage.center = self.view.center
        notFoundImage.frame = CGRect(x: self.view.frame.origin.x , y: 300, width: self.view.frame.width * 0.9, height: self.view.frame.width * 0.8)
    }
    
    func checkIsTeamNotFound(){
        stduimTeamImageView.isHidden = true
        teamImgaView.isHidden = true
        teamNameLabel.isHidden = true
        studimNameLabel.isHidden = true
        leagueName.isHidden = true
        myViewOne.isHidden = true
        yearLabel.isHidden = true
        tshirtImageView.isHidden = true
        myViewTwo.isHidden = true
        instaButton.isHidden = true
        self.view.addSubview(notFoundImage)
        notFoundImage.isHidden = false
    }
    
    @IBAction func youTubeDidPressed(_ sender: UIButton) {
        guard let youTubeStr = selectedTeam?.strYoutube else {return}
        self.animationWithButton(viewAnimation: sender)
        goToWeb(webStr: youTubeStr)
    }
    @IBAction func instaDidPressed(_ sender: UIButton) {
        guard let instaStr = selectedTeam?.strInstagram else {return}
        self.animationWithButton(viewAnimation: sender)
        goToWeb(webStr: instaStr)
    }
    @IBAction func faceBookDidPressed(_ sender: UIButton) {
        guard let faceBookStr = selectedTeam?.strFacebook else {return}
        self.animationWithButton(viewAnimation: sender)
        goToWeb(webStr: faceBookStr)
    }
    @IBAction func twitterDidPressed(_ sender: UIButton) {
        guard let twitterStr = selectedTeam?.strTwitter else {return}
        self.animationWithButton(viewAnimation: sender)
        goToWeb(webStr: twitterStr)
    }
    
    func goToWeb(webStr: String){
        UIApplication.shared.open(URL(string: "https://\(webStr)")! as URL, options: [:], completionHandler: nil)
    }
    
    func animationWithButton(viewAnimation: UIView){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            
            viewAnimation.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn) {
                
                viewAnimation.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { _ in
            }
        }
    }
}
