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
    var bucKitItemService: BucKitItemService
    
    let map = MKMapView()
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        view.addAnnotations(getAnnotations())
        
        return view
        
    }
    
    func getAnnotations() -> [MKAnnotation] {
        let bucKitItems = bucKitItemService.items
        var annotations: [MKAnnotation] = []
        for item in bucKitItems {
            guard let latitude = item.latitude, let longitude = item.longitude else {return []}
            let name = item.name
            let subName = item.stringDate()
            let annotation = MKPointAnnotation()
            annotation.subtitle = subName
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
            
            annotations.append(annotation)
        }
        return annotations
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "BucKitItem"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotation is MKUserLocation {
                return nil
            }
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView?.image = UIImage(named: "testImage")?.resizedRoundedImage()
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    }
    
}


