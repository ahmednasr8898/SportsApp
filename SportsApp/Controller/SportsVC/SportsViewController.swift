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
    var activityView = UIActivityIndicatorView()
    var noInternetimageView = UIImageView()
    var reachability: Reachability?
    var sporstArray: [Sport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivityIndicatory()
        createNoInterNetConnectImage()
        setupCollectionView()
        setupRefreshControl()
        checkNetworkConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNetworkConnection()
    }
    
    func createActivityIndicatory() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
    
    func createNoInterNetConnectImage(){
        let image = UIImage(named: "no-internet-connection")
        noInternetimageView = UIImageView(image: image!)
        noInternetimageView.center = self.view.center
        view.addSubview(noInternetimageView)
    }
}

extension SportsViewController{
    func setupRefreshControl(){
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(addActionWhenRefresh), for: .valueChanged)
        self.sportsCollectionView.addSubview(refreshControl)
    }
    
    @objc func addActionWhenRefresh(){
        self.checkNetworkConnection()
        refreshControl.endRefreshing()
        self.sportsCollectionView.reloadData()
    }
}

extension SportsViewController{
    func checkNetworkConnection(){
        Helper.shared.checkNetworkConnectionUsingRechability { networkIsConnect in
            if networkIsConnect{
                self.sportsCollectionView.isHidden = false
                self.activityView.isHidden = true
                self.noInternetimageView.isHidden = true
                if self.sporstArray.isEmpty{
                    self.getAllSports()
                }
                
            }else{
                Helper.shared.displayMessage(titleMessage: "Network Error!!", bodyMessage: "please check your network", messageError: true)
                self.sportsCollectionView.isHidden = true
                self.activityView.isHidden = true
                self.noInternetimageView.isHidden = false
                self.view.backgroundColor = .white
            }
        }
    }
}

extension SportsViewController{
    func getAllSports(){
        noInternetimageView.isHidden = true
        sportsCollectionView.isHidden = true
        activityView.isHidden = false
        activityView.startAnimating()
        Networking.shared.getAllSports { sportsModel, error in
            guard let sports = sportsModel?.sports, error == nil else { return }
            self.activityView.isHidden = true
            self.noInternetimageView.isHidden = true
            self.sportsCollectionView.isHidden = false
            self.activityView.stopAnimating()
            self.sporstArray = sports
            self.sportsCollectionView.reloadData()
        }
    }
}
