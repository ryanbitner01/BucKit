//
//  BucKitApp.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI

@main
struct BucKitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabs()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

