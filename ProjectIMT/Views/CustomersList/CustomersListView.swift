//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct CustomersListView: View {
    
    @EnvironmentObject var customerData: CustomersListManager //stores our pre-added data, via the @Published customers property.
    
    @State private var selection: Set<UUID> = [] //used to expand/collapse the customer sections
    @State var customerSelected: Int = 0 //stores the clicked customer for action buttons
   
    //delete transformation alert
    @State private var showDeleteConfirmationAlert: Bool = false
    
    //add transformation alert
    @State private var transformationNameToAdd: String? = ""
    @State private var showAddTransformationAlert: Bool = false
    
    //add and edit customer sheets
    @State private var showAddCustomerSheet: Bool = false
    @State private var showEditCustomerSheet: Bool = false
    
    //MARK: VIEW
    
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
                                    
                                    //edit Customer button + sheet
                                    EditCustomerAction(customer_index: id1)
                                    
                                    
                                    //delete Customer button + confirmation alert
                                    DeleteCustomerAction(customer_index: id1)
                                    
                                    //add Transformation button
                                    AddTransformationButton(customer_index: id1)
                                    
                                    Spacer()
                                    
                                    //Number of Transformations per customer
                                    NumberOfTransformation(customer_index: id1)
                    
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
                } .textFieldAlert(isPresented: $showAddTransformationAlert) { () -> TextFieldAlert in
                    TextFieldAlert(title: "Ajouter une transformation", message: "", text: $transformationNameToAdd, doneAction: addTransformation)
                }
            }
        }
    }
    
    //MARK: VIEW FUNCTIONS
    
    func EditCustomerAction(customer_index: Int) -> some View {
        Button(action: {customerSelected = customer_index; showEditCustomerSheet = true }) {
            Image(systemName: "pencil")
                .foregroundColor(Color.blue)
        } .sheet(isPresented: $showEditCustomerSheet) {
            EditCustomerSheet(showEditCustomerSheet: $showEditCustomerSheet,
                              customerSelected: customerSelected)
        }
    }
    
    func DeleteCustomerAction(customer_index: Int) -> some View {
        Button(role: .destructive, action: {
            customerSelected = customer_index
            showDeleteConfirmationAlert = true})
        {
            Image(systemName: "trash")
        }
        .alert(isPresented: $showDeleteConfirmationAlert) {
            Alert(title: Text("Delete " + customerData.customers[customerSelected].first_name + " ?"),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .destructive(Text("Delete"), action: deleteCustomer )
            )
        }
    }
    
    func AddTransformationButton(customer_index: Int) -> some View {
        Button(action: {
            customerSelected = customer_index
            showAddTransformationAlert = true}) {
                Image(systemName: "plus.circle").foregroundColor(Color.green)
            }
        //we can not add the .TextFieldAlert() here because as we did it, it is not appliable on a Button()
    }
    
    func NumberOfTransformation(customer_index: Int) -> some View {
        Text(String(customerData.customers[customer_index].number_of_transformations))
            .foregroundColor(.blue)
            .font(.system(size: 15.0))
            .fontWeight(.light)
    }
    
    //MARK: VIEWMODEL FUNCTIONS
    
    func deleteRow(customer_index: Int, indexes: IndexSet?) {
        let customer = customerData.customers[customer_index]
        let customer_id = customer.id
        
        //as we do not use the multi-delete property of the list, we just want one index
        let transformation_index = indexes!.first!
        let transformation_id = customer.transformation_list[transformation_index].id
        
        customerData.deleteTransformation(customer_id: customer_id, transformation_id: transformation_id)
    }
    
    func deleteCustomer() {
        let customer_id = customerData.customers[self.customerSelected].id
        customerData.deleteCustomer(customer_id: customer_id)
    }
    
    func addTransformation() {
        let customer_id = customerData.customers[self.customerSelected].id
        customerData.addTransformation(customer_id: customer_id,
                                       transformation_name: transformationNameToAdd!)
    }
    
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersListView()
            .environmentObject(CustomersListManager())
    }
}
#endif
