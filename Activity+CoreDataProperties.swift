//
//  Activity+CoreDataProperties.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//
//

import Foundation
import CoreData

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var location: String?
    @NSManaged public var name: String?

}

extension Activity : Identifiable {

}
