//
//  TabView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI
import MapKit

struct MainTabs: View {
    
    let testItem = BuckitItem(name: "Paris", location: nil, date: Date())
    
    var body: some View {
        TabView {
            WorldView()
                .tabItem {
                    Image(systemName: "globe")
                }
            
            BucKitListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabs()
    }
}
