//
//  ContentView.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/23/21.
//

import SwiftUI
import MapKit

struct WorldView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 39.320980, longitude: -111.093735), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var presentNewView: Bool = false
    
    var body: some View {
        TabView {
            
            NavigationView {
                Map(coordinateRegion: $region)
                    .navigationTitle("Map View")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: presentNewItemView, label: {
                        Image(systemName: "plus")
                    }))
                    .fullScreenCover(isPresented: $presentNewView, content: {
                        Text("Add new item view")
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
