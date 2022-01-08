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
    @State private var showDeleteConfirmationAlert: Bool = false
    @State private var customerIdToDelete: Int? //because there is only one alert, it needs to know which row we clicked
    
    var body: some View {
        VStack {
            NavigationView {
                List(selection: $selection) {
                    ForEach(customerData.customers.indices, id: \.self) { id1 in
                        Section(content: {
                            ForEach(customerData.customers[id1].transformation_list.indices, id: \.self) { id2 in
                                TransformationItemRow(transformation: $customerData.customers[id1].transformation_list[id2])
                            }.onDelete(perform: { indices in
                                deleteRow(customer_id: id1, indexes: indices)
                            })
                        }, header: {
                            HStack {
                                Text(customerData.customers[id1].first_name)
                                Button(action: {return} ) {
                                    Image(systemName: "pencil").foregroundColor(Color.blue)
                                }
                                Button(action: {return} ) {
                                    Image(systemName: "plus.circle").foregroundColor(Color.green)
                                }
                                
                                Button(role: .destructive,
                                       action: {showDeleteConfirmationAlert = true; customerIdToDelete = id1}
                                ) {
                                    Image(systemName: "trash")
                                }
                            }
                        }) {
                            
                        }
                    }
                }
                  .listStyle(SidebarListStyle())
                  .navigationTitle("Transformations")
                  .alert(isPresented: $showDeleteConfirmationAlert) {
                      Alert(title: Text("Are you sure you want to delete this transformation ?"),
                            primaryButton: .default(Text("Cancel")),
                            secondaryButton: .destructive(Text("Delete"), action: { deleteCustomer(customer_id: customerIdToDelete!)} )
                      )
                  }
            }
        }
    }
    
    func deleteRow(customer_id: Int, indexes: IndexSet?) {
        //we modifiy our customerData (which is shared across all views, as an @StateObject)
        customerData.deleteTransformation(customer_id: customer_id, transformation_indexes: indexes)
    }
    
    func deleteCustomer(customer_id: Int) {
        customerData.deleteCustomer(customer_id: customer_id)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(CustomerData())
    }
}
