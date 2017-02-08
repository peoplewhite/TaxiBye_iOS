//
//  Taxi+CoreDataProperties.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/8.
//  Copyright © 2017年 oddesign. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Taxi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Taxi> {
        return NSFetchRequest<Taxi>(entityName: "Taxi");
    }

    @NSManaged public var avg_rating: NSDecimalNumber?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var driver: String?
    @NSManaged public var plate_number: String?
    @NSManaged public var updated_at: NSDate?

}
