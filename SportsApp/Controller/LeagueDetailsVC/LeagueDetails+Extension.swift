//
//  LeagueDetails+Extension.swift
//  SportsApp
//
//  Created by Nasr on 02/03/2022.
//

import Foundation
import UIKit


extension LeagueDetailsViewController{
    func setLeagueID(){
        Helper.shared.getLeagueID { id in
            self.leagueID = id
        }
    }
    
    func getLeagueID(){
        Helper.shared.getLeagueID { leagueID in
            self.getAllLatestEvents(leagueID: leagueID)
        }
    }
}

extension LeagueDetailsViewController{
    func checkLeagueIsFoundInFavorite(){
        guard let isFound = leagueIsFoundInFavorite else {return}
        if isFound {
            favoriteBtn.isSelected = true
            self.favoriteBtn.image = UIImage(systemName: "heart.fill")
        }else{
            self.favoriteBtn.image = UIImage(systemName: "heart")
        }
    }
}

extension LeagueDetailsViewController{
    func selectedFavoritBtn(sender: UIBarButtonItem){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            //button selected
            self.favoriteBtn.image = UIImage(systemName: "heart.fill")
            self.addNewLeagueToFavorite()
        }
        else{
            //button non selected
            self.favoriteBtn.image = UIImage(systemName: "heart")
            nonSelectedLeagueToFavorite()
        }
    }
}

extension LeagueDetailsViewController{
    func addNewLeagueToFavorite(){
        let league = LeagueDataModel(context: context)
        guard let selectedLeague = selectedLeague else {return}
        league.idLeague = selectedLeague.idLeague
        league.strYoutube = selectedLeague.strYoutube
        league.strBadge = selectedLeague.strBadge
        league.strLeague = selectedLeague.strLeague
        league.strSport = selectedLeague.strSport
        league.strWebsite = selectedLeague.strWebsite
        
        do{
            try self.context.save()
            self.showToastMessege(message: "Add To Favorite")
        }catch{
            print("Error in addNewLeagueToFavorite", error.localizedDescription)
        }
    }
}

extension LeagueDetailsViewController{
    func nonSelectedLeagueToFavorite(){
        getAllFavoriteLeague()
        for league in leagues{ //selectedLeague?.idLeague
            if league.idLeague == leagueID{
                self.context.delete(league)
            }
            do{
                try self.context.save()
            }catch{
                print("Error when delete league: ", error.localizedDescription)
            }
        }
    }
}

extension LeagueDetailsViewController{
    func getAllFavoriteLeague(){
        do{
            self.leagues = try self.context.fetch(LeagueDataModel.fetchRequest())
        }catch{
            print("Error in getAllFavoriteLeague function: ", error.localizedDescription)
        }
    }
}
