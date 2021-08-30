//
//  ListView.swift
//  BucKit
//
//  Created by Caleb Greer on 8/29/21.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Activity.entity(),sortDescriptors:[NSSortDescriptor(keyPath: \Activity.name, ascending: true)])
    var fetchResults: FetchedResults<Activity>
    
    var body: some View {
            if fetchResults.isEmpty {
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
                List(fetchResults, id: \.self) { results in
                    HStack {
                        Image(systemName: "circle")
                            .padding(10)
                        VStack {
                            Text("\(results.name ?? "Error")")
                                .font(.system(size: 14))
                            Spacer(minLength: 10)
                            Text("\(results.location ?? "Error")")
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
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
