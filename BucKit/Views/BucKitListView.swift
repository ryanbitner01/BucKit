//
//  BucKitListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/26/21.
//

import SwiftUI

struct BucKitListView: View {
    
    @State var presentNewView: Bool = false
    var bucKitItems: [BuckitItem] = []
    
    struct FullScreenModalView: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Button("Dismiss Modal") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
            NavigationView {
                List(bucKitItems) {item in
                    NavigationLink(destination: BucketItemDetailView(item: item)) {
                        HStack {
                            CircleImage(width: 50, image: item.imageURL)
                            Text(item.name)
                            Spacer()
                            Text(item.dateString)
                    }
                }
                    .navigationTitle("BucKit List")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: presentNewItemView, label: {
                        Image(systemName: "plus")
                    }))
                    .fullScreenCover(isPresented: $presentNewView, content: {
                        AddView()
                    })
            }
        }
    }
    func presentNewItemView() {
        presentNewView = true
    }
}

struct BucKitListView_Previews: PreviewProvider {
    static var previews: some View {
        BucKitListView()
    }
}
