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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.419220, longitude: -111.950684), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        TabView {
            NavigationView {
                Map(coordinateRegion: $region, showsUserLocation: true)
                    
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
    func presentNewItemView() {
        presentNewView = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
        
    }
    
}

