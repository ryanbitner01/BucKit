//
//  HotelResult.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

struct SearchResults {
    var results: [Results]
}

struct Results {
    var hotels: [Hotel]
}

struct Hotel {
    var name: String
    var ratePlan: RatePlan
}

struct RatePlan {
    var price: Price
}

struct Price {
    var current: String
    var info: String
    var additionalInfo: 
}
