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
        
//        Testing
//        let activity = Activity(context: context)
//        activity.name = "Test"
//
//        try! context.save()
//
//        addItem(name: "Paris", latitude: 48.856613, longitude: 2.352222, date: Date(), image: nil, id: UUID(), activities: [activity])
    }
    
    func removeItem(bucKitItem: BucKitItem) {
        context.delete(bucKitItem)
        
        //save
        saveContext()
        
    }
    
    func updateItem(_ item: BucKitItem, name: String, latitude: Double, longitude: Double, date: Date, image: Data?, activities: [Activity], location: String) {
        item.name = name
        item.latitude = latitude
        item.longitude = longitude
        item.date = date
        item.image = image
        item.addToActivities(NSSet(array: activities))
        item.location = location
        
        saveContext()
    }
    
    func addItem(name: String, latitude: Double, longitude: Double, date: Date, image: Data?, activities: [Activity], location: String) {
        // create new item
        let newBucKitItem = BucKitItem(context: context)
        newBucKitItem.name = name
        newBucKitItem.latitude = latitude
        newBucKitItem.longitude = longitude
        newBucKitItem.date = date
        newBucKitItem.image = image
        newBucKitItem.id = UUID().uuidString
        newBucKitItem.addToActivities(NSSet(array: activities))
        newBucKitItem.location = location
//         save
        saveContext()
        
    }
    
    func getBucKitItem(lat: Double, long: Double, items: [BucKitItem]) -> BucKitItem? {
        items.first(where: {$0.latitude == lat && $0.longitude == long})
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