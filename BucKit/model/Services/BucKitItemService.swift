//
//  BucKitItemService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/2/21.
//

import Foundation
import CoreData

class BucKitItemService: ObservableObject {
    @Published var items: [BucKitItem] = []
    let context = CoreDataStack.shared.persistentContainer.viewContext
    
    init() {
        fetchItems()
        
        //Testing
        let activity = Activity(context: context)
        activity.name = "Test"
        
        try! context.save()
        
        addItem(name: "TestName", latitude: 25, longitude: -76, date: Date(), image: nil, id: UUID(), activities: [activity])
    }
    
    func removeItem(bucKitItem: BucKitItem) {
        context.delete(bucKitItem)
        
        //save
        saveContext()
        
        //reload
        fetchItems()
    }
    
    func fetchItems() {
        do {
            self.items = try context.fetch(BucKitItem.fetchRequest())
            print("ITEMS")
            print(items)
        }
        catch {
            print(error)
        }
    }
    
    func addItem(name: String, latitude: NSDecimalNumber, longitude: NSDecimalNumber, date: Date, image: Data?, id: UUID, activities: [Activity]) {
        // create new item
        let newBucKitItem = BucKitItem(context: context)
        newBucKitItem.name = name
        newBucKitItem.latitude = latitude
        newBucKitItem.longitude = longitude
        newBucKitItem.date = date
        newBucKitItem.image = image
        newBucKitItem.id = id.uuidString
        newBucKitItem.addToActivities(NSSet(array: activities))
//         save
        saveContext()
        
//         reload
        fetchItems()
    }
    
    func saveContext() {
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
}
