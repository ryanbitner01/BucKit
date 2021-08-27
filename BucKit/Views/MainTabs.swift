//
//  TabView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI
import MapKit

struct MainTabs: View {
    
    let testItem = BuckitItem(name: "Paris", location: CLLocation(latitude: 39.320980, longitude: -111.093735), date: Date())
    
    var body: some View {
        TabView {
            WorldView()
                .tabItem {
                    Image(systemName: "globe")
                }
            
            BucKitView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            BucketItemDetailView(item: testItem)
                .tabItem {
                    Text("Detail")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabs()
    }
}
