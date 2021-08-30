//
//  MapView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import MapKit

struct MapView:  UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel
    
    let map = MKMapView()
    
    func makeCoordinator() -> Coordinator {
        
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        
    }
    
}


