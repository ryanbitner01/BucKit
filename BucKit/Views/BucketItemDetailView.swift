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
    @State var AddViewWithNavBarIsShown = false
    var body: some View {
            ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
                GeometryReader { geometry in
                    VStack(alignment: .center ,spacing: 25) {
                        CircleImage(width: geometry.size.width * 0.45, imageData: item.image)
                            .padding()
                        VStack {
                            Text("Name: \(item.name)")
                                .padding()
                            Text("Date: \(item.stringDate())")
                                .padding()
                            
                            Text("Location: \(item.location)")
                        }
                        VStack(alignment: .center) {
                            Text("Activities")
                                .font(.title2)
                                .padding()
                            
                        }
                        
                        VStack (alignment: .leading) {
                            ForEach(arrayOfActivities()) {activity in
                                HStack {
                                    Image(systemName: "circle.fill")
                                    Text(activity.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                            }
                        }
                        NavigationLink("Travel Planner", destination: TravelPlanner(item: item))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .navigationBarItems(trailing: Button(action: {
                    self.AddViewWithNavBarIsShown.toggle()
                }) {
                    Text("Edit")
                }.fullScreenCover(isPresented: $AddViewWithNavBarIsShown) {
                    AddViewWithNavigationBar(buckitItem: item)
                })
                .onAppear { item.loadPlaceMark() }
        }
    }
    
    func arrayOfActivities() -> [Activity] {
        return item.activities.map({$0})
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
