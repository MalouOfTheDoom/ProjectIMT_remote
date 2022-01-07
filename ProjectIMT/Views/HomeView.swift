//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var customers: [Customer] = CustomerData().customers
    @State private var selection: Set<UUID> = []
    @State private var updater: Bool = false
   
    var body: some View {
        VStack {
            Text(String(updater)) //TODO: refaire bien le model pour ne pas avoir besoin de forcer le rerendu
            NavigationView {
                List(selection: $selection) {
                    ForEach(customers.indices, id: \.self) { id1 in
                        Section(header: Text(self.customers[id1].first_name)) {
                            ForEach(customers[id1].transformation_list.indices, id: \.self) { id2 in
                                TransformationItemRow(transformation: self.$customers[id1].transformation_list[id2])
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
        updater.toggle() 
        customers[customer_id].transformation_list.remove(atOffsets: indexes!)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
