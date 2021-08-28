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
// This is a comment
    var body: some Scene {
        WindowGroup {
            MainTabs()
                .environment(\.managedObjectContext, CoreDataStack.shared.viewContext)
        }
    }
}

