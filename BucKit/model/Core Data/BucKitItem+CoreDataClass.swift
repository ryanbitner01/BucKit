//
//  BucKitItem+CoreDataClass.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/7/21.
//
//

import Foundation
import CoreData

@objc(BucKitItem)
public class BucKitItem: NSManagedObject {
    func loadPlaceMark() {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // 1
            if let error = error {
                print(error)
            }
            // 2
            guard let placemark = placemarks?.first else { return }
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
            
            CoreDataStack.shared.saveContext()
            
            ActivityController.shared.saveAndReload()
        }
    }
    
    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
