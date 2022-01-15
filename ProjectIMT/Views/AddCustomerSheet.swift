//
//  AddCustomerSheet.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 15/01/2022.
//

import SwiftUI

struct AddCustomerSheet: View {
    
    @Binding var showAddCustomerSheet: Bool
    @EnvironmentObject var customerData: CustomerData
    @State var first_name: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Prénom", text: $first_name) .padding()
            }
            Button("Ajouter patient") {
                customerData.addCustomer(first_name: first_name)
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
