// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueModel = try? newJSONDecoder().decode(LeagueModel.self, from: jsonData)

import Foundation

// MARK: - LeagueModel
struct LeagueModel: Codable {
    let countrys: [Country]?
}

// MARK: - Country
struct Country: Codable {
    let idLeague: String?
    let idSoccerXML: String?
    let idAPIfootball, strSport, strLeague, strLeagueAlternate: String?
    let intDivision, idCup, strCurrentSeason, intFormedYear: String?
    let dateFirstEvent, strGender, strCountry, strWebsite: String?
    let strFacebook: String?
    let strInstagram: String?
    let strTwitter, strYoutube, strRSS, strDescriptionEN: String?
    let strDescriptionDE, strDescriptionFR, strDescriptionIT, strDescriptionCN: String?
    let strDescriptionJP, strDescriptionRU, strDescriptionES, strDescriptionPT: String?
    let strDescriptionSE, strDescriptionNL, strDescriptionHU, strDescriptionNO: String?
    let strDescriptionPL, strDescriptionIL, strTvRights, strFanart1: String?
    let strFanart2, strFanart3, strFanart4, strBanner: String?
    let strBadge, strLogo: String?
    let strPoster, strTrophy: String?
    let strNaming: String?
    let strComplete: String?
    let strLocked: String?
}
