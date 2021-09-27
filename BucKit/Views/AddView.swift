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
    
    var buckitItem: BucKitItem? = nil
    
    
    var body: some View {
        if #available(iOS 15.0, *) {
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
                    HStack {
                        Image(systemName: "staroflife.fill")
                        Text(" = Required")
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
                                presentationMode.wrappedValue.dismiss()
                            case .failure(_):
                                showAlert.toggle()
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                    })).disabled(name.isEmpty || locationString.isEmpty == true)
                    
                }
            }
            .alert("Invalid Location", isPresented: $showAlert, actions: {}, message: {Text("Please check spelling and try again.")})
            //        .alert(
            //                    "Unable to locate", isPresented: $showAlert, presenting: nil
            //                ) { message: { detail in
            //                    Text("Location is invalid, check spelling.")
            //                }
            .onAppear(perform: {
                updateUI()
            })
        } else {
            // Fallback on earlier versions
        }
    }
    func updateUI() {
        if let buckitItem = buckitItem {
            name = buckitItem.name
            locationString = buckitItem.location
            date = buckitItem.date
            savedActivities = arrayOfActivities()
            self.image = buckitItem.image
        }
    }
    func arrayOfActivities() -> [Activity] {
        return buckitItem?.activities.map({$0}) ?? []
    }
    
    func addBucKitItem(latitude: Double, longitude: Double) {
        if let item = buckitItem {
            bucketItemService.updateItem(item, name: name, latitude: latitude, longitude: longitude, date: date, image: image, activities: savedActivities, location: locationString)
        } else {
            bucketItemService.addItem(name: name, latitude: latitude, longitude: longitude, date: date, image: image, activities: savedActivities, location: locationString)
        }
    }
    
    func addActivity() {
        
        let newActivity = activityService.addActivity(name: newActivityName)
        
        savedActivities.append(newActivity)
        newActivityName = ""
        
    }
    
    func deleteActivity(activity: Activity) {
        if let index = savedActivities.lastIndex(where: { $0.id == activity.id })  {
            let activity = savedActivities.remove(at: index)
            activityService.deleteActivity(activity: activity)
        }
    }
}

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    let item: BucKitItem? = nil
    
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
        if #available(iOS 15.0, *) {
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
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
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
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
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
                HStack {
                    Image(systemName: "staroflife.fill")
                        .foregroundColor(.red)
                    Text("= Required")
                        .foregroundColor(.red)
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
                            presentationMode.wrappedValue.dismiss()
                        case .failure(_):
                            showAlert.toggle()
                        }
                    }
                }, label: {
                    Text("Save")
                })).disabled(name.isEmpty || locationString.isEmpty == true)
            }
            .alert("Invalid Location", isPresented: $showAlert, actions: {}, message: {Text("Please check spelling and try again.")})
        } else {
            // Fallback on earlier versions
        }
    }
    func addBucKitItem(latitude: Double, longitude: Double) {
        if let item = item {
            bucketItemService.updateItem(item, name: name, latitude: latitude, longitude: longitude, date: date, image: image, activities: savedActivities, location: locationString)
        }
        bucketItemService.addItem(name: name, latitude: latitude, longitude: longitude, date: date, image: image, activities: savedActivities, location: locationString)
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



