//
//  Item+CoreDataProperties.swift
//  BucKit
//
//  Created by Caleb Greer on 8/27/21.
//
//

import Foundation
import CoreData


extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Item")
    }

    @NSManaged public var activity: String?

}

extension Data : Identifiable {

}
