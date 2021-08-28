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
    
    @State private var cancelPressed = false
    @State private var addPressed = false
    @State private var name = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var newActivity = ""
    @State private var usedActivity: [String] = [String]()
    @State private var isShowingPhotoPicker = false
    @State private var defaultImage  = CircleImage(width: 1000, image: nil).uiImage
    @State private var onDefault = true
    @State private var showAlert: Bool = false
    @State private var sourceType: Int = 0
    @State private var image: Image?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack {
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
                    Spacer(minLength: 10)
                    Text("Name:")
                        .font(.system(size: 19))
                    Spacer(minLength: 128)
                    TextField("Enter goal name", text: $name)
                        .multilineTextAlignment(.center)
                        .frame(height: 0)
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
                    Spacer(minLength: 105)
                    TextField("Enter location name", text: $location)
                        .frame(height: 0)
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
                        Spacer(minLength: 15)
                        TextField("Type Activity Here", text: $newActivity, onCommit: addNewWord)
                        Spacer()
                        Button(action: addNewWord,label: {
                            Image(systemName: "plus")
                        })
                        .foregroundColor(.blue)
                    }
                    List(usedActivity, id: \.self) {
                        Text($0)
                    }
                    
                }
            }
            .navigationTitle("Add View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: cancel, label: {
                Text("Cancel")
                
            }), trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Save")
            }))
        }
    }
    func addNewWord() {
        let answer = newActivity.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        usedActivity.insert(answer, at: 0)
        newActivity = ""
        addPressed = true
        
    }
    
    func cancel() {
        cancelPressed = true
        presentationMode.wrappedValue.dismiss()
    }
    
    func actionSheet() {

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



