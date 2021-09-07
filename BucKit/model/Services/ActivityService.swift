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

    func addActivity(name: String) {
        let newActivity = Activity(context: context)
        newActivity.name = name
        newActivity.id = UUID().uuidString
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
            print(activities)
        }
        catch {
            print(error)
        }
    }
}
