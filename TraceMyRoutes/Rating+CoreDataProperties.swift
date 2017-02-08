//
//  Rating+CoreDataProperties.swift
//  
//
//  Created by sean on 2017/2/8.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Rating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        return NSFetchRequest<Rating>(entityName: "Rating");
    }

    @NSManaged public var created_at: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var message: String?
    @NSManaged public var score: Double
    @NSManaged public var trip_feeling_id: Int32
    @NSManaged public var trip_id: Int32
    @NSManaged public var update_at: NSDate?

}
