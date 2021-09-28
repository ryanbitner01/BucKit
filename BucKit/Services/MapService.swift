//
//  MapService.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/28/21.
//

import Foundation
import CoreData
import SwiftUI
import MapKit

class MapService: NSObject , ObservableObject, CLLocationManagerDelegate {
    
    @Published var searchTxt: String = ""
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: MKUserLocation().coordinate,
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    @Published var places: [Place] = []
    
    @Published var authorizationStatus: CLAuthorizationStatus
    
    @Published var userLocation: CLLocation?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        userLocation = locationManager.location
        
        guard let userLocation = userLocation else {
            return
        }
        self.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)

    }
        
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        MKLocalSearch(request: request).start {(response, _) in
            
            guard let result = response else { return }
            
            self.places = result.mapItems.compactMap({(item) -> Place? in
                return Place(placemark: item.placemark)
            })
        }
        
    }
    
    func setRegion(place: Place) {
        searchTxt = ""
        guard let location = place.placemark.location?.coordinate else {return}
        region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func focusUserLocation() {
        guard let userLocation = userLocation else {return}
        region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.first else {return}
        self.userLocation = lastLocation
    }
}
