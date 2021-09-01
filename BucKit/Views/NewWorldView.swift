//
//  NewWorldView.swift
//  BucKit
//
//  Created by Ryan Bitner on 9/1/21.
//

import SwiftUI
import MapKit

struct NewWorldView: View {
    @State private var region = MKCoordinateRegion(
    @ObservedObject var activityController: ActivityController
    
    var body: some View {
        Map(coordinateRegion: <#T##Binding<MKCoordinateRegion>#>, annotationItems: <#T##RandomAccessCollection#>, annotationContent: <#T##(Identifiable) -> MapAnnotationProtocol#>)
    }
}

struct NewWorldView_Previews: PreviewProvider {
    static var previews: some View {
        NewWorldView()
    }
}
