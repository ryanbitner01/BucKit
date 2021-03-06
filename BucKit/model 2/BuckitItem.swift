//
//  BuckitItem.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import Foundation
import MapKit

class BuckitItem: ObservableObject {
    var name: String
    let id: UUID = UUID()
    let location: CLLocation?
    let date: Date
    var address: String = ""
    let activities: [String]
    var dateString: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM yyyy"
      dateFormatter.locale = Locale(identifier: "en_US")
      return dateFormatter.string(from: date)
    }
    
    init(name: String, location: CLLocation?, date: Date, activities: [String] = []) {
        self.name = name
        self.location = location
        self.date = date
        self.activities = activities
    }
    
    func loadPlaceMark() {
      if let location = location {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
          // 1
          if let error = error {
            print(error)
          }
          // 2
          guard let placemark = placemarks?.first else { return }
          print(placemark)
          // Geary & Powell, Geary & Powell, 299 Geary St, San Francisco, CA 94102, United States @ <+37.78735352,-122.40822700> +/- 100.00m, region CLCircularRegion (identifier:'<+37.78735636,-122.40822737> radius 70.65', center:<+37.78735636,-122.40822737>, radius:70.65m)
          // 3
          let streetNumber = placemark.subThoroughfare ?? ""
          let streetName = placemark.thoroughfare ?? ""
          guard let city = placemark.locality else { return }
          guard let state = placemark.administrativeArea else { return }
          guard let zipCode = placemark.postalCode else { return }
          // 4
          let address = "\(streetNumber) \(streetName) \(city), \(state), \(zipCode)"
          self.address = address
        }
      } else {
      self.address = "N/A"
      }
    }
}
