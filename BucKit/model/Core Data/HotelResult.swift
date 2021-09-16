//
//  HotelResult.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/15/21.
//

import Foundation

struct SearchResults: Codable {
    var searchResults: Results
}

struct Results: Codable {
    var results: [HotelResult]
}

struct HotelResult: Codable {
    var name: String
    var ratePlan: RatePlan
}

struct RatePlan: Codable {
    var price: Price
}

struct Price: Codable {
    var current: String
    var fullyBundledPricePerStay: String?
}
