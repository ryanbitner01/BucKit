//
//  AddView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI
import CoreData

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var cancelPressed = false
    @State private var addPressed = false
    @State private var deletePressed = false
    @State var name = ""
    @State var location = ""
    @State var date = Date()
    @State private var savedActivities: [Activity] = [Activity]()
    @State private var newActivityName = ""
    @State private var isShowingPhotoPicker = false
    @State private var defaultImage  = CircleImage(width: 1000, image: nil).uiImage
    @State private var onDefault = true
    @State private var showAlert: Bool = false
    @State private var sourceType: Int = 0
    @State private var image = Data()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack {
                    Spacer()
                    if onDefault == true {
                        Image(uiImage: defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } else {
                        Image(uiImage: defaultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                    Button("Change Image", action: {
                        self.isShowingPhotoPicker.toggle()
                    })
                    .padding()
                    .sheet(isPresented: $isShowingPhotoPicker, content: {
                        ImagePicker(show: $isShowingPhotoPicker, image: self.$image)
                    })
                    if showAlert {
                        
                    }
                }
                
                HStack {
                    Spacer(minLength: 15)
                    Text("Name:")
                        .font(.system(size: 19))
                    Spacer(minLength: 45)
                    TextField("Enter goal name", text: $name)
                    .contentShape(Rectangle())
                    .multilineTextAlignment(.center)
                    .frame(height: 10)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.blue, lineWidth: 2))
                    
                    .padding()
                }
                HStack {
                    Spacer(minLength: 10)
                    Text("Location:")
                        .font(.system(size: 20))
                    Spacer(minLength: 25)
                    TextField("Enter location name", text: $location)
                    .contentShape(Rectangle())
                    .frame(height: 10)
                    .multilineTextAlignment(.center)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.blue, lineWidth: 2))
                    .padding()
                }
                
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
                .navigationBarItems(leading: Button(action: cancel, label: {
                    Text("Cancel")
                    
                }), trailing: Button(action: {
                    BucKitItemService.shared.addItem(name: name, latitude: 0, longitude: 0, date: date, image: image, id: UUID(), activities: savedActivities)
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                })
            }
        }
    }
func addActivity() {
    let newActivity = Activity(context: viewContext)
    newActivity.name = newActivityName
    newActivity.id = UUID().uuidString
    
    savedActivities.append(newActivity)
    
    
}

    func deleteActivity(activity: Activity) {
        if let index = savedActivities.lastIndex(where: { $0.id == activity.id })  {
            savedActivities.remove(at: index)
    }
    
}
func cancel() {
    cancelPressed = true
    presentationMode.wrappedValue.dismiss()
}
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}



