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
        }
        catch {
            print(error)
        }
    }
    
    func addItem(name: String, latitude: NSDecimalNumber, longitude: NSDecimalNumber, date: Date, image: Data?, id: UUID) {
        // create new item
        let newBucKitItem = BucKitItem(context: context)
        newBucKitItem.name = name
        newBucKitItem.latitude = latitude
        newBucKitItem.longitude = longitude
        newBucKitItem.date = date
        newBucKitItem.image = image
        newBucKitItem.id = id.uuidString
        items.append(newBucKitItem)
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
