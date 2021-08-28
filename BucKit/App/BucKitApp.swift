//
//  BucKitApp.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI

@main
struct BucKitApp: App {
<<<<<<< Updated upstream
    let persistenceController = PersistenceController.shared

=======
    let persistenceController = CoreDataStack.shared
// This is a comment
>>>>>>> Stashed changes
    var body: some Scene {
        WindowGroup {
            MainTabs()
                .environment(\.managedObjectContext, CoreDataStack.shared.viewContext)
        }
    }
}

