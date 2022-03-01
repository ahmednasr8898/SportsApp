//
//  LeagueDataModel+CoreDataProperties.swift
//  
//
//  Created by Nasr on 01/03/2022.
//
//

import Foundation
import CoreData


extension LeagueDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeagueDataModel> {
        return NSFetchRequest<LeagueDataModel>(entityName: "LeagueDataModel")
    }

    @NSManaged public var idLeague: String?
    @NSManaged public var strSport: String?
    @NSManaged public var strLeague: String?
    @NSManaged public var strWebsite: String?
    @NSManaged public var strYoutube: String?
    @NSManaged public var strBadge: String?

}
