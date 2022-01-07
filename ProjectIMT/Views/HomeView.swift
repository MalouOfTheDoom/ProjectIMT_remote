//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var customerData: CustomerData //CustomerData is a class that stores our pre-added data. When it's @published "customers" property is modified, all the views that use customerData will update.
    @State private var selection: Set<UUID> = []
    
    var body: some View {
        VStack {
            NavigationView {
                List(selection: $selection) {
                    ForEach(customerData.customers.indices, id: \.self) { id1 in
                        Section(header: Text(customerData.customers[id1].first_name)) {
                            ForEach(customerData.customers[id1].transformation_list.indices, id: \.self) { id2 in
                                TransformationItemRow(transformation: $customerData.customers[id1].transformation_list[id2])
                            }.onDelete(perform: { indices in
                                deleteRow(customer_id: id1, indexes: indices)
                            })
                        }
                    }
                }
                  .listStyle(SidebarListStyle())
                  .navigationTitle("Transformations")
            }
        }
    }
    
    func deleteRow(customer_id: Int, indexes: IndexSet?) {
        //we modifiy our customerData (which is shared across all views, as an @StateObject)
        customerData.deleteTransformation(customer_id: customer_id, transformation_indexes: indexes)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
