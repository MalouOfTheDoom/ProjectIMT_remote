//
//  AddCustomerSheet.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 15/01/2022.
//

import SwiftUI

struct AddCustomerSheet: View {
    
    @Binding var showAddCustomerSheet: Bool
    @EnvironmentObject var customerData: CustomersListManager
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var birthday_date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("Prénom", text: $first_name) .padding()
                TextField("Nom", text: $last_name) .padding()
                DatePicker(
                        "Date de naissance",
                        selection: $birthday_date,
                        displayedComponents: [.date]
                    )
            }
            Button("Ajouter patient") {
                customerData.addCustomer(first_name: first_name, last_name: last_name, birthday_date: birthday_date)
                self.showAddCustomerSheet = false
            }
        }
    }
}

//struct AddCustomerSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCustomerSheet()
//    }
//}
