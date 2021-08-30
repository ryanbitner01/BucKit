//
//  BucKitController.swift
//  BucKit
//
//  Created by Caleb Greer on 8/27/21.
//

import Foundation
import CoreData


class BucKitController {
    
    static let shared = BucKitController()
        
    var inputs = [Data]()

    var newInput: Data?
    let input: Data = Data()
    
    func createEntry(activity: String) {
    
        updateInput(activity: activity)
    }
    
    func updateInput(activity: String) {
        input.activity = activity
        
    }
    
    func deleteInput(item: Data) {
        input.managedObjectContext?.delete(input)
        
        
    }
    
    
    func saveAndReload() {
        CoreDataStack.shared.saveContext()
        loadEntries()
    }
    
    private
    func loadEntries() {
        let request = NSFetchRequest<Data>(entityName: "Item")
        do {
            self.inputs = try CoreDataStack.shared.viewContext.fetch(request)
        } catch ( let error ){
            print(error.localizedDescription)
            self.inputs = []
        }
        
        
    }
    init() {
        self.loadEntries()
    }
}
