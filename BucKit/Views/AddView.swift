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
    @State var usedActivity: [String] = [String]()
    @State private var newActivity = ""
    @State private var isShowingPhotoPicker = false
    @State private var defaultImage  = CircleImage(width: 1000, image: nil).uiImage
    @State private var onDefault = true
    @State private var showAlert: Bool = false
    @State private var sourceType: Int = 0
    @State private var image: Image?
    @State private var showtextFieldToolbar = false
    
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
                        ImagePickerView(isPresent: self.$isShowingPhotoPicker, selectedImage: self.$defaultImage)
                    })
                    if showAlert {
                        
                    }
                }
                
                HStack {
                    Spacer(minLength: 15)
                    Text("Name:")
                        .font(.system(size: 19))
                    Spacer(minLength: 45)
                    TextField("Enter goal name", text: $name) {
                        isChanged in
                        if isChanged {
                            showtextFieldToolbar = true
                        }
                    } onCommit: {
                        showtextFieldToolbar = false
                    }
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
                    TextField("Enter location name", text: $location) {
                        isChanged in
                        if isChanged {
                            showtextFieldToolbar = true
                        }
                    } onCommit: {
                        showtextFieldToolbar = false
                    }
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
                        TextField("Type Activity Here", text: $newActivity) {
                            isChanged in
                            if isChanged {
                                showtextFieldToolbar = true
                            }
                        } onCommit: {
                            showtextFieldToolbar = false
                            addActivity()
                        }
                        Image(systemName: "plus")
                            .onTapGesture {
                                addActivity()
                            }
                            .foregroundColor(.blue)
                    }
                    List(usedActivity, id: \.self) {
                        
                        Image(systemName: "circle.fill")
                            .foregroundColor(.black)
                        Text($0)
                        Spacer()
                        Button(action: {
                            deleteActivity()
                        }, label: {
                            Image(systemName: "trash")
                        })
                    }
                }
                
                
                .navigationTitle("Add View")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: cancel, label: {
                    Text("Cancel")
                    
                }), trailing: Button(action: {
                    let newActivity = Activity(context: viewContext)
                    newActivity.id = UUID()
                    newActivity.name = self.name
                    newActivity.location = self.location
                    newActivity.date = self.date
                    newActivity.image = self.defaultImage.jpegData(compressionQuality: 0.5)
                    
                    do {
                        try viewContext.save()
                        print("Saved")
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Save")
                })
                VStack {
                    Spacer()
                    if showtextFieldToolbar {
                        HStack {
                            Spacer()
                            Button("Close") {
                                showtextFieldToolbar = false
                                UIApplication.shared
                                    .sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
                            }
                            .foregroundColor(Color.black)
                            .padding(.trailing, 12)
                        }
                        .frame(idealWidth: .infinity, maxWidth: .infinity,
                               idealHeight: 44, maxHeight: 44,
                               alignment: .center)
                        .background(Color.secondary)
                    }
                }
            }
        }
    }
    func addActivity() {
        let answer = newActivity.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        usedActivity.insert(answer, at: 0)
        newActivity = ""
        addPressed = true
        
    }
    
    func deleteActivity() {
        for id in usedActivity {
            if let index = usedActivity.lastIndex(where: { $0 == id })  {
                usedActivity.remove(at: index)
            }
        }
        usedActivity = [String]()
    }
    func cancel() {
        cancelPressed = true
        presentationMode.wrappedValue.dismiss()
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresent: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.parent.selectedImage = image
            }
            self.parent.isPresent = false
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}



