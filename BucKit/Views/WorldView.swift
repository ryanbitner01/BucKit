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

struct WorldView: View {
    
    @State var presentNewView: Bool = false
    @State var searchBar: String = ""
    
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    @State private var currentLocation = CLLocationCoordinate2D()
    @State private var list: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView()
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                
                VStack {
                    
                    VStack(spacing: 0) {
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $mapData.searchTxt)
                                .colorScheme(.light)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.white)
                        
                        if !mapData.places.isEmpty && mapData.searchTxt != "" {
                            
                            ScrollView {
                                
                                VStack(spacing: 15) {
                                    
                                    ForEach(mapData.places) { place in
                                        
                                        Text(place.placemark.name ?? "")
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                
                                                mapData.selectPlace(place: place)
                                                
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
                            Button(action: mapData.focusLocation, label: {
                                Image(systemName: "location.fill")
                                    .font(.title2)
                                    .padding(10)
                                    .background(Color.primary)
                                    .clipShape(Circle())
                            })
                            
                            Button(action: mapData.updateMapType, label: {
                                Image(systemName: mapData.mapType == .standard ? "network" : "map")
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
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
            })
            
            .alert(isPresented: $mapData.permissionDenied, content: {
                Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Settings"), action: {
                    
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
            })
            .onChange(of: mapData.searchTxt, perform: { value in
                
                let delay = 0.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    if value == mapData.searchTxt {
                        
                        self.mapData.searchQuery()
                    }
                }
            })
            .navigationTitle("Map View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: showList, label: {
                Image(systemName: "list.bullet")
            })
            .fullScreenCover(isPresented: $list, content: {
                ListView()
            }), trailing: Button(action: presentNewViewPressed, label: {
                Image(systemName: "plus")
            }))
            .fullScreenCover(isPresented: $presentNewView, content: {
                AddView()
            })
        }
    }
    func presentNewViewPressed() {
        presentNewView = true
    }
    func showList() {
        self.list.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldView()
        
    }
}




