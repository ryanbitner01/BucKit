//
//  TravelPlanner.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/13/21.
//

import SwiftUI

struct TravelPlanner: View {
    
    @State private var hotels: [HotelResult] = []
    @State var item: BucKitItem
    var hotelNetworkService = HotelNetworkService()
    @State var numOfAdults = 1
    @State var address: String = ""
    @State private var checkinDate = Date()
    @State private var checkoutDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    var body: some View {
        Form {
            Section {
                Text("Location: \(item.location)")
                Text("Address: \(address)")
            }
            Section {
                Stepper("Number of Adults: \(numOfAdults)", value: $numOfAdults, in: 1...5)
                DatePicker("Check-in Date", selection: $checkinDate, in: Date()..., displayedComponents: .date)
                    
                DatePicker("Check-out Date", selection: $checkoutDate, in: tomorrow... ,displayedComponents: .date)
            }
            Section {
                Button(action: getHotels, label: {
                    Text("Get Hotels")
                })
            }
            Section {
                HotelList(hotels: hotels)
            }
        }
        .onAppear(perform: getAddress)
        .navigationBarTitle("Travel Planner")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getHotels() {
        //Call Hotel Service
        hotelNetworkService.searchHotels(item, adults: String(numOfAdults), checkinDate: checkinDate, checkoutDate: checkoutDate) { result in
            switch result {
            case .success(let hotels):
                DispatchQueue.main.async {
                    self.hotels = hotels
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getAddress() {
        item.loadPlaceMark { result in
            switch result {
            case .success(let address):
                self.address = address
            case .failure(_):
                self.address = "No Address"
            }
        }
    }
}

struct TravelPlanner_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let item = BucKitItem(context: context)
        item.name = "Paris"
        item.date = Date()
        item.latitude = 48.856613
        item.longitude = 2.352222
        return TravelPlanner(item: item)
    }
}
