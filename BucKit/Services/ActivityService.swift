//
//  ActivityService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/7/21.
//

import Foundation

class ActivityService: ObservableObject {
        
    @Published var activities: [Activity] = []
    
    let context = CoreDataStack.shared.persistentContainer.viewContext
    
    init() {
        fetchActvities()
    }
    
    func deleteActivity(activity: Activity) {
        context.delete(activity)
        
        saveContext()
    }

    func addActivity(name: String) -> Activity {
        let newActivity = Activity(context: context)
        newActivity.name = name
        newActivity.id = UUID().uuidString
        saveContext()
        fetchActvities()
        return newActivity
      }
    
   func saveContext() {
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func fetchActvities() {
        do {
            self.activities = try context.fetch(Activity.fetchRequest())
        }
        catch {
            print(error)
        }
    }
}
