//
//  ListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.editMode) var mode
    
    @FetchRequest(entity: BucKitItem.entity(), sortDescriptors: [])
    var items: FetchedResults<BucKitItem>
    
    @ObservedObject var bucketItemService: BucKitItemService = BucKitItemService()
    @ObservedObject var activityService: ActivityService = ActivityService()
    
    @State var detailView: Bool = false
    @State var presentDetail: Bool = false
    @State private var inactive: EditMode = EditMode.inactive
    
    var body: some View {
        if items.isEmpty {
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
        }   else {
            List {
                ForEach(items, id: \.id) { result in
                    NavigationLink(
                        destination: BucketItemDetailView(item: result),
                        label: {
                            VStack {
                                HStack {
                                    Text("\(result.name )")
                                        .font(.system(size: 14))
                                    Divider()
                                    Spacer(minLength: 10)
//                                    Text("\(results ?? "Error")")
                                        .font(.system(size: 14))
                                    Spacer()
                                    Divider()
                                    Text("Not Completed")
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
    }
    
    func onDelete(offsets: IndexSet) {

    }
}



struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
