//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    let data: MockCustomerData = MockCustomerData()
    @State private var selection: Set<UUID> = []
   
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(data.customers) { customer in
                    Section(header: Text(customer.first_name)) {
                        ForEach(customer.transformation_list) { transformation in
                            TransformationItemRow(transformation: transformation)
                        }
                    }
                }
            }
              .listStyle(SidebarListStyle())
              .navigationTitle("Transformations")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
