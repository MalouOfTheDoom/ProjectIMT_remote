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
    @State private var customerSelected: Int? //because there is only one alert, it needs to know which row we clicked
    @State private var transformationNameToAdd: String? = ""
    @State private var showAddTransformationAlert: Bool = false
    
    
    var body: some View {
        VStack {
            NavigationView {
                List(selection: $selection) {
                    ForEach(customerData.customers.indices, id: \.self) { id1 in
                        Section(content: {
                            ForEach(customerData.customers[id1].transformation_list.indices, id: \.self) { id2 in
                                TransformationItemRow(transformation: $customerData.customers[id1].transformation_list[id2])
                            }.onDelete(perform: { indices in
                                deleteRow(customer_index: id1, indexes: indices)
                            })
                        }, header: {
                            HStack {
                                Text(customerData.customers[id1].first_name)
                                
                                //edit Customer button
                                Button(action: {return} ) {
                                    Image(systemName: "pencil").foregroundColor(Color.blue)
                                }
                                
                                //delete Customer button
                                Button(role: .destructive,
                                       action: {showDeleteConfirmationAlert = true; customerSelected = id1}) {
                                    Image(systemName: "trash")
                                } .alert(isPresented: $showDeleteConfirmationAlert) {
                                    Alert(title: Text("Delete " + customerData.customers[customerSelected!].first_name + " ?"),
                                          primaryButton: .default(Text("Cancel")),
                                          secondaryButton: .destructive(Text("Delete"), action: { deleteCustomer(customer_index: customerSelected!)} )
                                    )
                                }
                                
                                //add Transformation button
                                Button(action: {showAddTransformationAlert = true; customerSelected = id1} ) {
                                    Image(systemName: "plus.circle").foregroundColor(Color.green)
                                }
                            }
                        })
                    }
                }
                  .listStyle(SidebarListStyle())
                  .navigationTitle("Transformations")
                  .textFieldAlert(isPresented: $showAddTransformationAlert) { () -> TextFieldAlert in
                      TextFieldAlert(title: "Alert Title", message: "Alert Message", text: $transformationNameToAdd, addAction: addTransformation)
                  } 
                  
                  
            }
        }
    }
    
    func deleteRow(customer_index: Int, indexes: IndexSet?) { //we modifiy our customerData (which is shared across all views, as an @StateObject)
        let customer_id = customerData.customers[customer_index].id
        let transformation_index = indexes!.first!
        let transformation_id = customerData.customers[customer_index].transformation_list[transformation_index].id
        customerData.deleteTransformation(customer_id: customer_id, transformation_id: transformation_id)
    }
    
    func deleteCustomer(customer_index: Int) {
        let customer_id = customerData.customers[customer_index].id
        customerData.deleteCustomer(customer_id: customer_id)
    }
    
    func addTransformation() {
        print("heyy")
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(CustomerData())
    }
}
