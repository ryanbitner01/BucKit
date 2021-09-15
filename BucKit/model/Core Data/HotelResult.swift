//
//  HotelResult.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

struct SearchResults: Codable {
    var results: [Results]
}

struct Results: Codable {
    var hotels: [Hotel]
}

struct Hotel: Codable {
    var name: String
    var ratePlan: RatePlan
}

struct RatePlan: Codable {
    var price: Price
}

struct Price: Codable {
    var current: String
    var info: String
    var additionalInfo: String
    var fullyBundledPriceString: String
}
