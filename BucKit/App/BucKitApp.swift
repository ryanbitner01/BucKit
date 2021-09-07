//
//  BucKitApp.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI

@main
struct BucKitApp: App {
    let persistenceController = CoreDataStack.shared
    var bucKitItemService: BucKitItemService
    var activityService: ActivityService
    
    init() {
        self.bucKitItemService = BucKitItemService()
        self.activityService = ActivityService()
    }
    
// This is a comment
    var body: some Scene {
        WindowGroup {
            WorldView()
                .environmentObject(bucKitItemService)
            
        }
    }
}

