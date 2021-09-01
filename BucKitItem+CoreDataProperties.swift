//
//  BucKitItem+CoreDataProperties.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/1/21.
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
    @NSManaged public var activities: [String]?

}

extension BucKitItem : Identifiable {

}
