//
//  BucketItemDetailView.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import SwiftUI
import MapKit

struct BucketItemDetailView: View {
    
    @ObservedObject var item: BucKitItem
    @State var activities: [Activity] = []
        
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center ,spacing: 25) {
                CircleImage(width: geometry.size.width * 0.45, image: nil)
                    .padding()
                VStack {
                    Text("Name: \(item.name)")
                    .padding()
                    Text("Date: \(item.stringDate())")
                    .padding()
                    
                Text("Location: \(item.address)")
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("Activities")
                            .font(.title2)
                            .padding()
                        List(activities, id: \.id) {
                            Text("\($0.name)")
                        }
                    }
                }
            }
        } .onAppear {item.loadPlaceMark()
            getActivities()
        }
    }
    
    func getActivities() {
        let array = Array(arrayLiteral: item.activities) as? [Activity]
        self.activities = array ?? []
    }
}

struct BucketItemDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let item = BucKitItem(context: context)
        item.name = "Paris"
        item.date = Date()
        item.latitude = 48.856613
        item.longitude = 2.352222
        return BucketItemDetailView(item: item)
    }
}
