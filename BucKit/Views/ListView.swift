//
//  ListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @ObservedObject var bucketItemService: BucKitItemService
    
    var body: some View {
        if bucketItemService.items.isEmpty {
            List {
                HStack {
                    Spacer()
                    Divider()
                    Text("Please Create A Goal")
                        .font(.system(.largeTitle))
                    Divider()
                    Spacer()
                }
            }
        } else {
            NavigationView {
                List(bucketItemService.items, id: \.id) { result in
                    NavigationLink(destination: BucketItemDetailView(item: result)) {
                        HStack {
                            
                            Image(systemName: "circle")
                                .padding(10)
                            VStack {
                                Text("\(result.name)")
                                    .font(.system(size: 14))
                                Spacer(minLength: 10)
                                Text("\(result.address)")
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            Divider()
                            Text("Not Completed")
                                .padding()
                            
                        }
                    }
                }
            }
        }
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(bucketItemService: BucKitItemService())
    }
}
