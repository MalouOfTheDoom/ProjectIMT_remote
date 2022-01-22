//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct CustomersListView: View {
    
    @EnvironmentObject var customerData: CustomersListManager //CustomerData is a class that stores our pre-added data. When it's @published "customers" property is modified, all the views that use customerData will update.
    
    @State private var selection: Set<UUID> = []
    @State private var showDeleteConfirmationAlert: Bool = false
    @State var customerSelected: Int = 0 //because there is only one alert, it needs to know which row we clicked
   

    @State private var transformationNameToAdd: String? = ""
    @State private var showAddTransformationAlert: Bool = false
    
    @State private var showAddCustomerSheet: Bool = false
    @State private var showEditCustomerSheet: Bool = false
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationView {
                    List(selection: $selection) {
                        ForEach(customerData.customers.indices, id: \.self) { id1 in
                            Section(content: {
                                ForEach(customerData.customers[id1].transformation_list.indices, id: \.self) { id2 in
                                    TransformationItemRow(transformation: $customerData.customers[id1].transformation_list[id2])
                                        .frame(height: geometry.size.height/11, alignment: .center)
                                }.onDelete(perform: { indices in
                                    deleteRow(customer_index: id1, indexes: indices)
                                })
                            }, header: {
                                HStack {
                                    Text(customerData.customers[id1].first_name)
                                    
                                    //edit Customer button
                                    Button(action: {customerSelected = id1; showEditCustomerSheet = true }) {
                                        Image(systemName: "pencil").foregroundColor(Color.blue)
                                    } .sheet(isPresented: $showEditCustomerSheet) {
                                        EditCustomerSheet(showEditCustomerSheet: $showEditCustomerSheet, customerSelected: customerSelected)
                                    }
                                    
                                    //delete Customer button
                                    Button(role: .destructive,
                                           action: {customerSelected = id1; showDeleteConfirmationAlert = true}) {
                                        Image(systemName: "trash")
                                    } .alert(isPresented: $showDeleteConfirmationAlert) {
                                        Alert(title: Text("Delete " + customerData.customers[customerSelected].first_name + " ?"),
                                              primaryButton: .default(Text("Cancel")),
                                              secondaryButton: .destructive(Text("Delete"), action: { deleteCustomer()} )
                                        )
                                    }
                                    
                                    //add Transformation button
                                    Button(action: {customerSelected = id1; showAddTransformationAlert = true} ) {
                                        Image(systemName: "plus.circle").foregroundColor(Color.green)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(String(customerData.customers[id1].transformation_list.count))
                                        .foregroundColor(.blue)
                                        .font(.system(size: 15.0))
                                        .fontWeight(.light)
                                    
                                }
                            })
                        }
                    }
                      .listStyle(SidebarListStyle())
                      .navigationBarTitleDisplayMode(.inline)
                      .toolbar {
                          ToolbarItem(placement: .principal) {
                              HStack {
                                  Text("Patients").font(.headline)
                                  Button(action: {showAddCustomerSheet = true} ) {
                                      Image(systemName: "plus.circle").foregroundColor(Color.green)
                                  } .sheet(isPresented: $showAddCustomerSheet) {
                                      AddCustomerSheet(showAddCustomerSheet: $showAddCustomerSheet)
                                  }
                              }
                          }
                      }
                      
                      .textFieldAlert(isPresented: $showAddTransformationAlert) { () -> TextFieldAlert in
                          TextFieldAlert(title: "Ajouter une transformation", message: "", text: $transformationNameToAdd, doneAction: addTransformation)
                      }
                      
                    
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
    
    func deleteCustomer() {
        let customer_id = customerData.customers[self.customerSelected].id
        customerData.deleteCustomer(customer_id: customer_id)
    }
    
    func addTransformation() {
        let customer_id = customerData.customers[self.customerSelected].id
        customerData.addTransformation(customer_id: customer_id,transformation_name: transformationNameToAdd!)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersListView()
            .environmentObject(CustomersListManager())
    }
}
