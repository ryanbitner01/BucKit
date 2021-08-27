//
//  BuckitItem.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import Foundation
import MapKit

struct BuckitItem: Identifiable {
    var name: String
    let id: UUID = UUID()
    let location: MKMapItem?
    let date: Date
    let activities: [String]
    
    init(name: String, location: MKMapItem?, date: Date, activities: [String] = []) {
        self.name = name
        self.location = location
        self.date = date
        self.activities = activities
    }
    
}
