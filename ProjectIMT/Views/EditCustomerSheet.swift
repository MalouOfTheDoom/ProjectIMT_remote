//
//  EditCustomerSheet.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 20/01/2022.
//

import SwiftUI

struct EditCustomerSheet: View {
    
    @Binding var showEditCustomerSheet: Bool
    
    @EnvironmentObject var customersListManager : CustomersListManager
    
    var customerSelected : Int
    
    var body: some View {
        Form {
            Section {
                TextField("Prénom", text: $customersListManager.customers[customerSelected].first_name) .padding()
                TextField("Nom", text: $customersListManager.customers[customerSelected].last_name) .padding()
            }
            
            Section {
                DatePicker(
                    "Date de naissance",
                    selection: $customersListManager.customers[customerSelected].birthday_date,
                    displayedComponents: [.date]
                )
            }
        }
    }
}

#if DEBUG
struct EditCustomerSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditCustomerSheet(showEditCustomerSheet: .constant(true), customerSelected: 0)
            .environmentObject(CustomersListManager())
    }
}
#endif
