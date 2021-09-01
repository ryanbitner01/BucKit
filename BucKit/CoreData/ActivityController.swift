//
//  ActivityController.swift
//  BucKit
//
//  Created by Caleb Greer on 8/28/21.
//

import SwiftUI
import CoreData


class ActivityController: ObservableObject {
    
    static let shared = ActivityController()
        
    @Published var activities: [BucKitItem] = []
    var newActivity: BucKitItem?
    
    func createActivity(name: String, latitude: NSDecimalNumber, longitude: NSDecimalNumber, date: Date, image: Data?, id: UUID) {
        
        updateActivity(name: name, latitude: latitude, longitude: longitude, date: date, image: image, id: id)
        saveAndReload()
    }
    
    func updateActivity(name: String, latitude: NSDecimalNumber, longitude: NSDecimalNumber, date: Date, image: Data?, id: UUID) {
        
       

        
        saveAndReload()
        
    }

    func deleteActivity(activity: BucKitItem) {
        activity.managedObjectContext?.delete(activity)
        saveAndReload()
        
    }
    
    func saveAndReload() {
       CoreDataStack.shared.saveContext()
        loadEntries()
    }
    
    private
    func loadEntries() {
        let request = NSFetchRequest<BucKitItem>(entityName: "BucKitItem")
        do {
            self.activities = try CoreDataStack.shared.viewContext.fetch(request)
        } catch ( let error ){
            print(error.localizedDescription)
            self.activities = []
        }
    }
}
