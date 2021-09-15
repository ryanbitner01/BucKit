//
//  TravelPlanner.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/13/21.
//

import SwiftUI

struct TravelPlanner: View {
    
    @State private var hotels: [HotelResult] = []
    var hotelNetworkService = HotelNetworkService()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func getHotels() {
        hotelNetworkService.searchHotels(<#T##item: BucKitItem##BucKitItem#>, adults: <#T##String#>, checkinDate: <#T##String#>, checkoutDate: <#T##String#>, completion: <#T##(Result<[HotelResult], Error>) -> Void#>)
    }
}

struct TravelPlanner_Previews: PreviewProvider {
    static var previews: some View {
        TravelPlanner()
    }
}
