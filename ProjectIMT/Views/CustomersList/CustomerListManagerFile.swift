//
//  CustomerListManagerFile.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 22/01/2022.
//

import Foundation

//this class acts like the ViewModel for the Home page.
class CustomersListManager: ObservableObject {
    @Published var customers: [Customer] =
    [
        Customer(first_name: "John", transformation_list: [
            Transformation(name: "Opération du nez", before_date: Date()),
            Transformation(name: "Après une visite chez le dermatho"),
            Transformation()]),
        Customer(first_name: "Marc"),
        Customer(first_name: "Marie", transformation_list: [
            Transformation(name: "Dents de sagesses")])
    ]
    
    //Customers CRUD
    func addCustomer(first_name: String, last_name: String = "", birthday_date: Date = Date()) {
        let customer = Customer(first_name: first_name, last_name: last_name, birthday_date: birthday_date)
        self.customers.append(customer)
    }
    
    func getCustomer(customer_id: UUID) -> Customer? {
        if let index = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        }) {
            return customers[index]
        } else {
            return nil
        }
    }
    
    func deleteCustomer(customer_id: UUID) {
        if let index = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        }) {
            customers.remove(at: index)
        }
    }
    
    //Transformations CRUD
    func deleteTransformation(customer_id: UUID, transformation_id: UUID) {
        let index1 = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        })
        if index1 != nil {
            if let index2 = customers[index1!].transformation_list.firstIndex(where: { transformation in
                return transformation.id == transformation_id ? true : false
            }) {
                customers[index1!].transformation_list.remove(at: index2)
            }
        }
    }
    
    func addTransformation(customer_id: UUID, transformation_name: String) {
        let index = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        })
        if index != nil {
            self.customers[index!].transformation_list.append(Transformation(name: transformation_name))
        }
        
    }
    
    func getTransformation(customer_id: UUID, transformation_id: UUID) -> Transformation? {
        let index1 = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        })
        if index1 != nil {
            if let index2 = customers[index1!].transformation_list.firstIndex(where: { transformation in
                return transformation.id == transformation_id ? true : false
            }) {
                return customers[index1!].transformation_list[index2]
            }
        }
        return nil
    }
}
