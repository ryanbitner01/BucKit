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
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.editMode) var mode
    
    @State var presentNewView: Bool = false
    @State var goBack: Bool = false
    @State var detailView: Bool = false
    @State var presentDetail: Bool = false
    @State private var inactive: EditMode = EditMode.inactive
    
    var body: some View {
        if BucKitItemService.shared.items.isEmpty {
            NavigationView {
                List {
                    Button(action: presentNewViewPressed) {
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
                                    .fullScreenCover(isPresented: $presentNewView, content: {
                                        AddView()
                                    })
                                })
                        }
                        .navigationTitle("List View")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: goBackPressed, label: {
                            Image(systemName: "map")
                        })
                        .fullScreenCover(isPresented: $goBack, content: {
                            WorldView()
                        }))
                    }
                }
            }
        } else {
            NavigationView {
                List {
                    ForEach(BucKitItemService.shared.items, id: \.id) { result in
                        NavigationLink(
                            destination: BucketItemDetailView(item: result),
                            label: {
                                VStack {
                                    HStack {
                                        Text("\(result.name )")
                                            .font(.system(size: 14))
                                        Divider()
                                        Spacer(minLength: 10)
                                        Text("\(result.address )")
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
                }
                .navigationTitle("List View")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: goBackPressed, label: {
                    Image(systemName: "map")
                }), trailing:
                    HStack {
                        Spacer(minLength: 25)
                        Button(action: presentNewViewPressed, label: {
                            Image(systemName: "plus")
                        })
                        .fullScreenCover(isPresented: $goBack, content: {
                            WorldView()
                        })
                        .fullScreenCover(isPresented: $presentNewView, content: {
                            AddView()
                        })
                    })
                .environment(\.editMode, $inactive)
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
    func presentNewViewPressed() {
        presentNewView = true
        
    }
    
    func goBackPressed() {
        goBack = true
    }
    
    func onDelete(offsets: IndexSet) {
        for offset in offsets {
            let activity = BucKitItemService.shared.items[offset]
            viewContext.delete(activity)
        }
        try? viewContext.save()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
