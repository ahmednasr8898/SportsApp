// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upCommingModel = try? newJSONDecoder().decode(UpCommingModel.self, from: jsonData)

import Foundation

// MARK: - UpCommingModel
struct UpCommingModel: Codable {
    let events: [Event]?
}

// MARK: - Event
struct Event: Codable {
    let idEvent: String?
    let idSoccerXML: String?
    let idAPIfootball, strEvent, strEventAlternate, strFilename: String?
    let strSport, idLeague, strLeague, strSeason: String?
    let strDescriptionEN: String?
    let strHomeTeam, strAwayTeam: String?
    let intHomeScore: String?
    let intRound: String?
    let intAwayScore, intSpectators: String?
    let strOfficial: String?
    let strTimestamp: String?
    let dateEvent: String?
    let dateEventLocal: String?
    let strTime: String?
    let strTimeLocal, strTVStation: String?
    let idHomeTeam, idAwayTeam: String?
    let strResult: String?
    let strVenue, strCountry: String?
    let strCity: String?
    let strPoster, strSquare: String?
    let strFanart: String?
    let strThumb: String?
    let strBanner: String?
    let strMap, strTweet1, strTweet2, strTweet3: String?
    let strVideo: String?
    let strStatus, strPostponed, strLocked: String?
}
