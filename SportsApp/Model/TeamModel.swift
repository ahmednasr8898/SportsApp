//
//  TeamModel.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamModel = try? newJSONDecoder().decode(TeamModel.self, from: jsonData)

import Foundation

// MARK: - TeamModel
struct TeamModel: Codable {
    let teams: [Team]?
}

// MARK: - Team
struct Team: Codable {
    let idTeam, idSoccerXML, idAPIfootball, intLoved: String?
    let strTeam, strTeamShort, strAlternate, intFormedYear: String?
    let strSport, strLeague, idLeague, strLeague2: String?
    let idLeague2, strLeague3, idLeague3, strLeague4: String?
    let idLeague4: String?
    let strLeague5: String?
    let idLeague5: String?
    let strLeague6: String?
    let idLeague6: String?
    let strLeague7: String?
    let idLeague7, strDivision: String?
    let strManager, strStadium, strKeywords: String?
    let strRSS: String?
    let strStadiumThumb: String?
    let strStadiumDescription, strStadiumLocation, intStadiumCapacity, strWebsite: String?
    let strFacebook, strTwitter, strInstagram, strDescriptionEN: String?
    let strDescriptionDE, strDescriptionFR: String?
    let strDescriptionCN: String?
    let strDescriptionIT, strDescriptionJP, strDescriptionRU, strDescriptionES: String?
    let strDescriptionPT: String?
    let strDescriptionSE: String?
    let strDescriptionNL, strDescriptionHU: String?
    let strDescriptionNO: String?
    let strDescriptionIL, strDescriptionPL: String?
    let strGender, strCountry: String?
    let strTeamBadge, strTeamJersey, strTeamLogo: String?
    let strTeamFanart1, strTeamFanart2, strTeamFanart3, strTeamFanart4: String?
    let strTeamBanner: String?
    let strYoutube, strLocked: String?
    
}
