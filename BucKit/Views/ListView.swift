//
//  ListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @Environment(\.editMode) var mode
    
    @FetchRequest(entity: NSEntityDescription.entity(forEntityName: "BucKitItem", in: CoreDataStack.shared.viewContext)!, sortDescriptors: [])
    var results: FetchedResults<BucKitItem>
    
    @ObservedObject var bucketItemService: BucKitItemService = BucKitItemService()
    @State private var inactive: EditMode = EditMode.inactive
    
    var items: [BucKitItem] {
        Array(results)
    }
    
    var body: some View {
        List {
            ForEach(items) { result in
                NavigationLink(
                    destination: BucketItemDetailView(item: result),
                    label: {
                        VStack {
                            HStack {
                                CircleImage(width: 50, imageData: result.image)
                                Spacer()
                                Text("\(result.name )")
                                    .font(.system(size: 14))
                                Spacer()
                                Text("\(result.stringDate())")
                                    .padding()
                            }
                        }
                    })
            }
            .onDelete(perform: onDelete)
            .deleteDisabled(!self.inactive.isEditing)
            
        }
        .navigationTitle("List View")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                HStack {
            EditButton()
            Spacer(minLength: 25)
            NavigationLink(
                destination: AddView(),
                label: {
                    Image(systemName: "plus")
                })
        })
        .environment(\.editMode, $inactive)
        
        .overlay(
            Group {
                if items.isEmpty {
                    Text( "Please Press the + to add an Item")
                }
            }
        )
    }
    
    func onDelete(offsets: IndexSet) {
        guard let firstIndex = offsets.first else { return }
        let item = items[firstIndex]
        // Delete from core data
        bucketItemService.removeItem(bucKitItem: item)
    }
    
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
