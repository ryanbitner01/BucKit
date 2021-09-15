//
//  LocationService.swift
//  BucKit
//
//  Created by Caleb Greer on 9/10/21.
//

import Foundation
import CoreLocation

class LocationService {
    private let bucketItemService = BucKitItemService()

    func tryToSave(location: String, completion: @escaping (Result<CLLocation, Error>) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { placemarks, error in
            guard let placemark = placemarks,
                  let location = placemark.first?.location
            else {
                completion(.failure(error ?? NSError()))
                return
            }
            completion(.success(location))
                
        }
    }
    
}
