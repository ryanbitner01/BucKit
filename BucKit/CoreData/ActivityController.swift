//
//  ActivityController.swift
//  BucKit
//
//  Created by Caleb Greer on 8/28/21.
//

import SwiftUI
import CoreData


class ActivityController: NSManagedObject {
    
    static let shared = ActivityController()
        
    var activities = [Activity]()
    
    var newActivity: Activity?
    let activity: Activity = Activity()
    
    func createActivity(name: String, location: String, date: Date, image: UIImage, id: UUID) {
        
        updateActivity(name: name, location: location, date: date, image: image, id: id)
        saveAndReload()
    }
    
    func updateActivity(name: String, location: String, date: Date, image: UIImage, id: UUID) {
        
        activity.date = date
        activity.id = id
        activity.image = image.jpegData(compressionQuality: 0.5)
        activity.location = location
        activity.name = name


        
        saveAndReload()
        
    }

    func deleteActivity(activity: Activity) {
        activity.managedObjectContext?.delete(activity)
        saveAndReload()
        
    }
    
    func saveAndReload() {
       CoreDataStack.shared.saveContext()
        loadEntries()
    }
    
    private
    func loadEntries() {
        let request = NSFetchRequest<Activity>(entityName: "Activity")
        do {
            self.activities = try CoreDataStack.shared.container.viewContext.fetch(request)
        } catch ( let error ){
            print(error.localizedDescription)
            self.activities = []
        }
    }
}

extension ActivityController {
    static
    func getData() -> NSFetchRequest<ActivityController> {
        let request = ActivityController.fetchRequest() as! NSFetchRequest <ActivityController>
        return request
    }
}
