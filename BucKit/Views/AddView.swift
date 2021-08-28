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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                VStack{
                    Image(systemName: "mappin")
                        .resizable()
                        .frame(width: 100, height: 200)
                        .padding()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Select an Image")
                    })
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
}



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

