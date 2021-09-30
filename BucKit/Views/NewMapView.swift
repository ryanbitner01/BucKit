//
//  NewMapView.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/28/21.
//

import SwiftUI
import MapKit
import CoreData

struct NewMapView: View {
    
    @ObservedObject var mapService: MapService
    
    @FetchRequest(entity: NSEntityDescription.entity(forEntityName: "BucKitItem", in: CoreDataStack.shared.viewContext)!, sortDescriptors: [])
    var results: FetchedResults<BucKitItem>
        
    var body: some View {
        Map(coordinateRegion: $mapService.region, showsUserLocation: true, annotationItems: results.map {$0}) { item in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
                NavigationLink(destination: BucketItemDetailView(item: item), label: {
                    VStack(alignment: .center) {
                        CircleImage(width: 50, imageData: item.image)
                        Text(item.name)
                            .foregroundColor(.black)
                    }
                })
            }
        }
    }
}

struct NewMapView_Previews: PreviewProvider {
    static var previews: some View {
        NewMapView(mapService: MapService())
    }
}
