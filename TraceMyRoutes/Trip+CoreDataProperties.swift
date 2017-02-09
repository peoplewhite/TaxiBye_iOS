//
//  Trip+CoreDataProperties.swift
//  
//
//  Created by sean on 2017/2/8.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip");
    }

    @NSManaged public var created_at: NSDate?
    @NSManaged public var ended_at: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var route: String?
    @NSManaged public var started_at: NSDate?
    @NSManaged public var taxi_plate_number: String?
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var rating: Rating?

}
