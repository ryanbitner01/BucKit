//
//  Place.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    var placemark: CLPlacemark
}
