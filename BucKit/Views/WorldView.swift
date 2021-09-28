//
//  ContentView.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/23/21.
//

import SwiftUI
import MapKit
import UIKit
import CoreLocation
import CoreData

struct WorldView: View {
    
    @FetchRequest(entity: NSEntityDescription.entity(forEntityName: "BucKitItem", in: CoreDataStack.shared.viewContext)!, sortDescriptors: [])
    var results: FetchedResults<BucKitItem>
    
    let bucKitItemService = BucKitItemService()
    @ObservedObject var mapService = MapService()
    
    @State var searchBar: String = ""
    @State var locationManager = CLLocationManager()
    @State private var currentLocation = CLLocationCoordinate2D()
    @State var isShowingDetail = false
    @State var isShowingDetailAlert = false
    @State var selectedItem: MKPointAnnotation? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                NewMapView(mapService: mapService)
                VStack {
                    
                    VStack(spacing: 0) {
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $mapService.searchTxt)
                                .colorScheme(.light)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.white)
                        
                        if !mapService.places.isEmpty && mapService.searchTxt != "" {
                            
                            ScrollView {
                                
                                VStack(spacing: 15) {
                                    
                                    ForEach(mapService.places) { place in
                                        
                                        Text(place.placemark.name ?? "")
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                
                                                mapService.setRegion(place: place)
                                                
                                            }
                                        
                                        Divider()
                                    }
                                    
                                }
                                .padding(.top)
                            }
                            .background(Color.white)

                        }
                    }
                    
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        
                        VStack {
                            Button(action: mapService.focusUserLocation, label: {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                    .padding(10)
                                    .background(Color.primary)
                                    .clipShape(Circle())
                            })
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        
                    }
                }
                
            }

            .onAppear(perform: {
                mapService.requestPermission()

            })
            
//            .alert(isPresented: $mapData.permissionDenied, content: {
//                Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Settings"), action: {
//                    
//                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//                }))
//            })
            .onChange(of: mapService.searchTxt, perform: { value in
                
                let delay = 0.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    if value == mapService.searchTxt {
                        
                        self.mapService.searchQuery()
                    }
                }
            })
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:NavigationLink(
                                    destination: ListView(),
                                    label: {
                                        Image(systemName: "list.bullet")
                                    }), trailing: NavigationLink(
                                        destination: AddView(),
                                        label: {
                                            Image(systemName: "plus")
                                        }))
            
        }
//        .alert(isPresented: $isShowingDetailAlert, content: {
//            Alert(title: Text(selectedItem?.title ?? "Unknown"), message: Text(selectedItem?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Show Detail")) {
//                    isShowingDetail = true
//                })
//        })
//        .sheet(isPresented: $isShowingDetail, content: {
//            BuckitItemViewWithNavBar(item: getBucKitItem()!)
//        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
            .environmentObject(BucKitItemService())
        
    }
}




