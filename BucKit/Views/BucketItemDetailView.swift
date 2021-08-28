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
        GeometryReader { geometry in
            VStack(alignment: .center ,spacing: 25) {
                CircleImage(width: geometry.size.width * 0.45, image: nil)
                    .padding()
                Text("Name: \(item.name)")
                Text("Date: \(item.dateString)")
                Text("Location: \(item.address)")
                Section {
                    VStack(alignment: .leading) {
                        Text("Activities")
                            .font(.title2)
                            .padding()

                        List(item.activities , id: \.self) {activity in
                            HStack {
                                Image(systemName: "circle.fill")
                                Text(activity)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BucketItemDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        BucketItemDetailView(item: BuckitItem(name: "Test Name", location: CLLocation(latitude: 48.856613, longitude: 2.352222), date: Date(), activities: ["Test 1", "Test 2"]))
    }
}
