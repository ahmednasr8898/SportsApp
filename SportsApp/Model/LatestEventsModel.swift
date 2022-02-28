//
//  LatestEventsModel.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let latestEventsModel = try? newJSONDecoder().decode(LatestEventsModel.self, from: jsonData)

import Foundation

// MARK: - LatestEventsModel
struct LatestEventsModel: Codable {
    let events: [Event]?
}

