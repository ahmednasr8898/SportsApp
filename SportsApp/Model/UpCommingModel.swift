// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upCommingModel = try? newJSONDecoder().decode(UpCommingModel.self, from: jsonData)

import Foundation

// MARK: - UpCommingModel
struct UpCommingModel: Codable {
    let events: [Event]?
}
