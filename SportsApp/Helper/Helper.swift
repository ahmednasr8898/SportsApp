//
//  Helper.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

import Foundation

class Helper{
    
    static let shared = Helper()
    
    func setLeagueID(leagueID: String){
        UserDefaults.standard.set(leagueID, forKey: "LeagueID")
    }
    
    func getLeagueID(complition: @escaping (String) -> Void){
        guard let leagueID = UserDefaults.standard.object(forKey: "LeagueID") else {return}
        print("leaguID \(leagueID)")
        complition(leagueID as! String)
    }
    
    
}
