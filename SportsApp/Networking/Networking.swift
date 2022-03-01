//
//  Networking.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//
import Foundation
import Alamofire

class Networking{
    
    static let shared = Networking()
}

extension Networking{
    func getAllSports(complition: @escaping (SportsModel?, Error?)->Void){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                print("error")
                complition(nil, error)
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(SportsModel.self, from: data)
                    complition(json, nil)
                }catch let error{
                    print("error when get All sporst")
                    complition(nil, error)
                }
            }
        }
    }
}

extension Networking{
    func getAllLeagues(strSport: String, complition: @escaping (LeagueModel?, Error?)->Void){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=\(strSport)") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                complition(nil, error)
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(LeagueModel.self, from: data)
                    complition(json, nil)
                }catch let error{
                    complition(nil, error)
                }
            }
        }
    }
}

extension Networking{
    func getAllUpCommingEvents(leagueID: String, complition: @escaping (UpCommingModel? , Error?)->Void){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(leagueID)&r=38&s=2021-2022") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                complition(nil, error)
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(UpCommingModel.self, from: data)
                    complition(json, nil)
                }catch let error{
                    complition(nil, error)
                }
            }
        }
    }
}

extension Networking{
    func getAllLatestEvents(leagueID: String, complition: @escaping (LatestEventsModel?, Error?)-> Void){
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=\(leagueID)&r=20&s=2021-2022") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                complition(nil, error)
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(LatestEventsModel.self, from: data)
                    complition(json, nil)
                }catch let error{
                    complition(nil, error)
                }
            }
        }
    }
}

extension Networking{
    func getAllTeams(leagueName: String,complition: @escaping (TeamModel?, Error?)-> Void){
        let teamName = leagueName.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(teamName)") else {return}
       
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { res in
            switch res.result{
            case .failure(let error):
                complition(nil, error)
            case .success(_):
                guard let data = res.data else {
                    return
                }
                do{
                    let json = try JSONDecoder().decode(TeamModel.self, from: data)
                    complition(json, nil)
                }catch let error{
                    complition(nil, error)
                }
            }
        }
    }
}

