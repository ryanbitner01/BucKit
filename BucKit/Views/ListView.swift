//
//  ListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import CoreData

struct RegularListView: View {
    
    @Environment(\.editMode) var mode
    
    @State private var inactive: EditMode = EditMode.inactive
    
    var items: [BucKitItem]
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { result in
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
    }
    
    func onDelete(offsets: IndexSet) {

    }
}

struct EmptyActivitiesListView: View {
    
    var body: some View {
        List {
            NavigationLink(
                destination: AddView(),
                label: {
                    HStack {
                        Spacer()
                        Divider()
                        Text("Tap Here To Add A Goal")
                            .font(.system(.headline))
                        Divider()
                        Spacer()
                    }
                })
                .navigationTitle("List View")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.editMode) var mode
    
    @FetchRequest(entity: NSEntityDescription.entity(forEntityName: "BucKitItem", in: CoreDataStack.shared.viewContext)!, sortDescriptors: [])
    var results: FetchedResults<BucKitItem>
    
    var items: [BucKitItem] {
        results.map({$0})
    }
    
    @ObservedObject var bucketItemService: BucKitItemService = BucKitItemService()
    @ObservedObject var activityService: ActivityService = ActivityService()
    
    @State var detailView: Bool = false
    @State var presentDetail: Bool = false
    @State private var inactive: EditMode = EditMode.inactive
    
    var body: some View {
        if items.isEmpty {
            EmptyActivitiesListView()
        } else {
            RegularListView(items: items)
        }
    }
    
    
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
