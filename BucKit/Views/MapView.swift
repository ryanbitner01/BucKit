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
    
    @Binding var isShowingDetail: Bool
    @Binding var selectedItem: MKPointAnnotation?
    
    let map = MKMapView()
    var items: [BucKitItem]
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        getAnnotations()
        return view
        
    }
    
    func getAnnotations() {
        var annotations: [MKAnnotation] = []
        for item in items {
            let name = item.name
            let subName = item.stringDate()
            let annotation = MKPointAnnotation()
            annotation.subtitle = subName
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            
            annotations.append(annotation)
        }
        mapData.mapView.removeAnnotations(mapData.mapView.annotations)
        mapData.mapView.addAnnotations(annotations)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        getAnnotations()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {

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
                guard let item = BucKitItemService().getBucKitItem(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude, items: parent.items)
                else { return nil }
                if let data = item.image {
                    annotationView?.image = UIImage(data: data)? .resizedRoundedImage()
                } else {
                annotationView?.image = UIImage(named: "testImage")?.resizedRoundedImage()
                }
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let pointAnnotation = view.annotation as? MKPointAnnotation else {return}
            parent.selectedItem = pointAnnotation
            parent.isShowingDetail = true

        }
    }
    
}


