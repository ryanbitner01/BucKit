//
//  AddView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI
import CoreData

struct AddViewWithNavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    private let bucketItemService = BucKitItemService()
    private let activityService = ActivityService()
    private let locationService = LocationService()
    let buckitItem: BucKitItem?
    
    @State private var deletePressed = false
    @State var name = ""
    @State var locationString = ""
    @State var date = Date()
    @State private var savedActivities: [Activity] = [Activity]()
    @State private var newActivityName = ""
    @State private var isShowingPhotoPicker = false
    @State private var defaultImage  = CircleImage(width: 1000, imageData: nil).uiImage
    @State private var onDefault = true
    @State private var showAlert: Bool = false
    @State private var sourceType: Int = 0
    @State private var image: Data?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack {
                    Spacer()
                    CircleImage(width: 250, imageData: image != nil ? image: nil )
                    Button("Change Image", action: {
                        self.isShowingPhotoPicker.toggle()
                    })
                    .padding()
                    .sheet(isPresented: $isShowingPhotoPicker, content: {
                        ImagePicker(show: $isShowingPhotoPicker, image: self.$image)
                    })
                }
                
                HStack {
                    Spacer(minLength: 15)
                    Text("Name:")
                        .font(.system(size: 19))
                    Spacer(minLength: 45)
                    TextField("Enter goal name", text: $name)
                }
                .contentShape(Rectangle())
                .multilineTextAlignment(.center)
                .frame(height: 10)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue, lineWidth: 2))
                
                .padding()
                HStack {
                    Spacer(minLength: 10)
                    Text("Location:")
                        .font(.system(size: 20))
                    Spacer(minLength: 25)
                    TextField("Enter location name", text: $locationString)
                }
                .contentShape(Rectangle())
                .frame(height: 10)
                .multilineTextAlignment(.center)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue, lineWidth: 2))
                .padding()
                HStack {
                    Spacer(minLength: 10)
                    Text("Goal Date:")
                        .font(.system(size: 20))
                    Spacer(minLength: 105)
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .padding()
                }
                Spacer()
                Form {
                    HStack {
                        Text("Activity:")
                        TextField("Type Activity Here", text: $newActivityName)
                        Image(systemName: "plus")
                            .onTapGesture {
                                addActivity()
                            }
                            .foregroundColor(.blue)
                    }
                    List {
                        ForEach(savedActivities) { activity in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.black)
                                Text(activity.name)
                                Spacer()
                                Button(action: {
                                    deleteActivity(activity: activity)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            }
                        }
                    }
                }
                
                .navigationTitle("Add View")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                }), trailing: Button(action: {
                    locationService.tryToSave(location: locationString) { result in
                        switch result {
                        
                        case .success(let location):
                            addBucKitItem(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        case .failure(_):
                            print("Failed to save")
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                }))
                
            }
        }
        .onAppear(perform: {
            updateUI()
        })
    }
    func updateUI() {
        if let buckitItem = buckitItem {
            name = buckitItem.name
            locationString = buckitItem.location
            date = buckitItem.date
            savedActivities = arrayOfActivities()
        }
    }
    func arrayOfActivities() -> [Activity] {
        return buckitItem?.activities.map({$0}) ?? []
    }
    
    func addBucKitItem(latitude: Double, longitude: Double) {
        bucketItemService.addItem(name: name, latitude: latitude, longitude: longitude, date: date, image: image, id: UUID(), activities: savedActivities, location: locationString)
    }
    
    func addActivity() {
        
        let newActivity = activityService.addActivity(name: newActivityName)
        
        savedActivities.append(newActivity)
        newActivityName = ""
        
    }
    
    func deleteActivity(activity: Activity) {
        if let index = savedActivities.lastIndex(where: { $0.id == activity.id })  {
            savedActivities.remove(at: index)
        }
    }
}

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: BucKitItem.entity(), sortDescriptors: [])
    var items: FetchedResults<BucKitItem>
    
    private let bucketItemService = BucKitItemService()
    private let activityService = ActivityService()
    private let locationService = LocationService()
    
    @State private var deletePressed = false
    @State var name = ""
    @State var locationString = ""
    @State var date = Date()
    @State private var savedActivities: [Activity] = [Activity]()
    @State private var newActivityName = ""
    @State private var isShowingPhotoPicker = false
    @State private var defaultImage  = CircleImage(width: 1000, imageData: nil).uiImage
    @State private var onDefault = true
    @State private var showAlert: Bool = false
    @State private var sourceType: Int = 0
    @State private var image: Data?
    
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Spacer()
                CircleImage(width: 250, imageData: image != nil ? image: nil )
                Button("Change Image", action: {
                    self.isShowingPhotoPicker.toggle()
                })
                .padding()
                .sheet(isPresented: $isShowingPhotoPicker, content: {
                    ImagePicker(show: $isShowingPhotoPicker, image: self.$image)
                })
            }
            
            HStack {
                Spacer(minLength: 15)
                Text("Name:")
                    .font(.system(size: 19))
                Spacer(minLength: 45)
                TextField("Enter goal name", text: $name)
            }
            .contentShape(Rectangle())
            .multilineTextAlignment(.center)
            .frame(height: 10)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.blue, lineWidth: 2))
            
            .padding()
            HStack {
                Spacer(minLength: 10)
                Text("Location:")
                    .font(.system(size: 20))
                Spacer(minLength: 25)
                TextField("Enter location name", text: $locationString)
            }
            .contentShape(Rectangle())
            .frame(height: 10)
            .multilineTextAlignment(.center)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.blue, lineWidth: 2))
            .padding()
            HStack {
                Spacer(minLength: 10)
                Text("Goal Date:")
                    .font(.system(size: 20))
                Spacer(minLength: 105)
                DatePicker("", selection: $date, displayedComponents: .date)
                    .padding()
            }
            Spacer()
            Form {
                HStack {
                    Text("Activity:")
                    TextField("Type Activity Here", text: $newActivityName)
                    Image(systemName: "plus")
                        .onTapGesture {
                            addActivity()
                        }
                        .foregroundColor(.blue)
                }
                List {
                    ForEach(savedActivities) { activity in
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.black)
                            Text(activity.name)
                            Spacer()
                            Button(action: {
                                deleteActivity(activity: activity)
                            }, label: {
                                Image(systemName: "trash")
                            })
                        }
                    }
                }
            }
            
            .navigationTitle("Add View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                locationService.tryToSave(location: locationString) { result in
                    switch result {
                    
                    case .success(let location):
                        addBucKitItem(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    case .failure(_):
                        print("Failed to save")
                    }
                }
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
    func addBucKitItem(latitude: Double, longitude: Double) {
        bucketItemService.addItem(name: name, latitude: latitude, longitude: longitude, date: date, image: image, id: UUID(), activities: savedActivities, location: locationString)
    }
        
        func addActivity() {
            
            let newActivity = activityService.addActivity(name: newActivityName)
            
            savedActivities.append(newActivity)
            newActivityName = ""
            
        }
        
        func deleteActivity(activity: Activity) {
            if let index = savedActivities.lastIndex(where: { $0.id == activity.id })  {
                savedActivities.remove(at: index)
            }
        }
    }

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}



