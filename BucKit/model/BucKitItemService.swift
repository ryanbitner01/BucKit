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
    
    func fetchItems() {
        do {
            self.items = try context.fetch(BucKitItem.fetchRequest())
        }
        catch {
            print(error)
        }
    }
    
    func addItem(name: String, latitude: NSDecimalNumber, longitude: NSDecimalNumber, date: Date, image: Data?, id: UUID) {
        let newBucKitItem = BucKitItem(context: context)
        newBucKitItem.name = name
            
    }
}
