//
//  HotelList.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/17/21.
//

import SwiftUI


struct HotelList: View {
    
    var hotels: [HotelResult] = []
    
    var body: some View {
        List(hotels, id: \.name) { hotel in
            VStack(alignment: .leading, spacing: 5) {
                Text("Name: \(hotel.name)")
                Text("Price: \(hotel.ratePlan.price.current)")
                Text("Bundled Price: \(hotel.ratePlan.price.fullyBundledPricePerStay ?? "Not Found")")
            }
        }
    }
}

struct HotelList_Previews: PreviewProvider {
    static var previews: some View {
        HotelList(hotels: [HotelResult(name: "Test", ratePlan: RatePlan(price: Price(current: "275", fullyBundledPricePerStay: "1976")))])
    }
}
