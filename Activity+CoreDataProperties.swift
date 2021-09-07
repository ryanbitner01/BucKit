//
//  Activity+CoreDataProperties.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/7/21.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension Activity {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: BucKitItem)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: BucKitItem)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension Activity : Identifiable {

}
