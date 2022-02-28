//
//  Helper.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

import Foundation
import SwiftMessages
import Reachability

class Helper{
    static let shared = Helper()
    var reachability: Reachability?
}

extension Helper{
    func setLeagueID(leagueID: String){
        UserDefaults.standard.set(leagueID, forKey: "LeagueID")
    }
    
    func getLeagueID(complition: @escaping (String) -> Void){
        guard let leagueID = UserDefaults.standard.object(forKey: "LeagueID") else {return}
        print("leaguID \(leagueID)")
        complition(leagueID as! String)
    }
}

extension Helper{
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

extension Helper{
    func checkNetworkConnectionUsingRechability(complition: @escaping (Bool)-> Void){
        reachability = try! Reachability()
        guard let reachability = reachability else {return}
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                complition(true)
            } else {
                print("Reachable via Cellular")
                complition(true)
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            complition(false)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
