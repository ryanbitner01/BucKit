//
//  BucketItemDetailView.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import SwiftUI
import MapKit

struct BucketItemDetailView: View {
    @ObservedObject var item: BuckitItem
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Text("Name: \(item.name)")
                Text("Date: \(item.dateString)")
                Text("Location: \(item.address)")
                Spacer()
            }
        }
    }
}

struct BucketItemDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        BucketItemDetailView(item: BuckitItem(name: "Test Name", location: CLLocation(latitude: 48.856613, longitude: 2.352222), date: Date()))
    }
}
