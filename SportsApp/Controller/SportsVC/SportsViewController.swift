//
//  ViewController.swift
//  SportsApp
//
//  Created by Nasr on 22/02/2022.
//
import UIKit
import Alamofire
import Kingfisher
import Reachability
import SwiftMessages

class SportsViewController: UIViewController{
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    var reachability: Reachability?
    var sporstArray: [Sport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        getAllSports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNetworkConnection()
    }
    
    func setupCollectionView(){
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        sportsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

extension SportsViewController{
    func setupRefreshControl(){
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(addActionWhenRefresh), for: .valueChanged)
        self.sportsCollectionView.addSubview(refreshControl)
    }
    
    @objc func addActionWhenRefresh(){
        print("Refresh CollectionView")
        self.checkNetworkConnection()
        refreshControl.endRefreshing()
        self.sportsCollectionView.reloadData()
    }
}

extension SportsViewController{
    func checkNetworkConnection(){
        reachability = try! Reachability()
        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                self.displayMessage(titleMessage: "Network Done", bodyMessage: "network back", messageError: false)
            } else {
                print("Reachable via Cellular")
                self.displayMessage(titleMessage: "Network Done", bodyMessage: "network back", messageError: false)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.displayMessage(titleMessage: "Network Error!!", bodyMessage: "please check your network", messageError: true)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

extension SportsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sporstArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        if let sportImageStr = sporstArray[indexPath.row].strSportThumb,let sportImageUrl = URL(string: sportImageStr), let sportName = sporstArray[indexPath.row].strSport {
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

extension SportsViewController{
    func displayMessage(titleMessage: String, bodyMessage: String , messageError: Bool){
       
        let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
        
        if messageError{
            view.configureTheme(.error)
        }else{
            view.configureTheme(.success)
        }
        view.iconImageView?.isHidden = false
        view.iconLabel?.isHidden = true
        view.titleLabel?.text = titleMessage
        view.bodyLabel?.text = bodyMessage
        view.titleLabel?.textColor = UIColor.white
        view.bodyLabel?.textColor = UIColor.white
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
}


//upcomming https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38
