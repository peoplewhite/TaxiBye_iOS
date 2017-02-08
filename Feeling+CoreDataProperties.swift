//
//  Feeling+CoreDataProperties.swift
//  TraceMyRoutes
//
//  Created by sean on 2017/2/8.
//  Copyright © 2017年 oddesign. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Feeling {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feeling> {
        return NSFetchRequest<Feeling>(entityName: "Feeling");
    }

    @NSManaged public var created_at: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var updated_at: NSDate?

}
