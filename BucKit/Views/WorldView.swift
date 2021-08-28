//
//  ContentView.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/23/21.
//

import SwiftUI
import MapKit

struct WorldView: View {
    
    @State var presentNewView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                MapView()
                    .frame(height: 550)
                List {
                    HStack {
                        Text("Test")
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "trash")
                        })
                        .navigationTitle("Map View")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button(action: presentNewItemView, label: {
                            Image(systemName: "plus")
                        }))
                        .fullScreenCover(isPresented: $presentNewView, content: {
                            AddView()
                        })
                    }
                }
            }
            
        }
    }
    
    func presentNewItemView() {
        presentNewView = true
    }
}

struct MapView: UIViewRepresentable {
    
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
        
    }
    
}

