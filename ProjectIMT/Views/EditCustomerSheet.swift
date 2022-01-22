//
//  EditCustomerSheet.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 20/01/2022.
//

import SwiftUI

//class EditCustomerSheetViewModel: ObservableObject {
//
//    @Published var first_name: String
//
//    func setup(_ customersListManager: CustomersListManager) {
//
//    }
//}

struct EditCustomerSheet: View {
    
    @Binding var showEditCustomerSheet: Bool
    
    @EnvironmentObject var customersListManager : CustomersListManager
    
    @Binding var customerSelected : Int
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    
    @State var birthday_date_toggle: Bool = false
    @State var birthday_date = Date()
    
    @State var showAlert = false
    
    var body: some View {
        Form {
            Section {
                TextField("Prénom", text: $customersListManager.customers[customerSelected].first_name) .padding()
                TextField("Nom", text: $customersListManager.customers[customerSelected].last_name) .padding()
            }
            
            Section {
                Toggle("Ajouter une date de naissance ?", isOn: $birthday_date_toggle)
                    .font(.subheadline)
                if birthday_date_toggle {
                    DatePicker(
                            "Date de naissance",
                            selection: $birthday_date,
                            displayedComponents: [.date]
                        )
                }
            }
            
            Button("Ajouter patient") {
                self.addPatient()
            } .alert("Veuillez saisir le prénom du patient...", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    func addPatient() {
//        if (self.first_name != "") {
//            let birthday_date = self.birthday_date_toggle ? self.birthday_date : nil
//
//            customersListManager.addCustomer(first_name: first_name,
//                                             last_name: last_name,
//                                             birthday_date: birthday_date)
//            self.showEditCustomerSheet = false
//        } else {
//            print("hello")
//            self.showAlert = true
//        }
    }
}

#if DEBUG
//struct EditCustomerSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCustomerSheet(showEditCustomerSheet: .constant(true))
//    }
//}
#endif
