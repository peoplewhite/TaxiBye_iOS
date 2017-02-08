//
//  Taxi+CoreDataProperties.swift
//  
//
//  Created by sean on 2017/2/8.
//
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
    @NSManaged public var trips: NSSet?
    @NSManaged public var ratings: NSSet?

}

// MARK: Generated accessors for trips
extension Taxi {

    @objc(addTripsObject:)
    @NSManaged public func addToTrips(_ value: Trip)

    @objc(removeTripsObject:)
    @NSManaged public func removeFromTrips(_ value: Trip)

    @objc(addTrips:)
    @NSManaged public func addToTrips(_ values: NSSet)

    @objc(removeTrips:)
    @NSManaged public func removeFromTrips(_ values: NSSet)

}

// MARK: Generated accessors for ratings
extension Taxi {

    @objc(addRatingsObject:)
    @NSManaged public func addToRatings(_ value: Rating)

    @objc(removeRatingsObject:)
    @NSManaged public func removeFromRatings(_ value: Rating)

    @objc(addRatings:)
    @NSManaged public func addToRatings(_ values: NSSet)

    @objc(removeRatings:)
    @NSManaged public func removeFromRatings(_ values: NSSet)

}
