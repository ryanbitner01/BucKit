//
//  AddView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI

struct AddView: View {
    
    @State var cancelPressed: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                
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
