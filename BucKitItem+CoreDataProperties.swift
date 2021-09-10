//
//  BucKitItem+CoreDataProperties.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/7/21.
//
//

import Foundation
import CoreData


extension BucKitItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BucKitItem> {
        return NSFetchRequest<BucKitItem>(entityName: "BucKitItem")
    }

    @NSManaged public var address: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var image: Data?
    @NSManaged public var latitude: NSDecimalNumber?
    @NSManaged public var longitude: NSDecimalNumber?
    @NSManaged public var name: String
    @NSManaged public var activities: Set<Activity>

}

// MARK: Generated accessors for activities
extension BucKitItem {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension BucKitItem : Identifiable {

}
