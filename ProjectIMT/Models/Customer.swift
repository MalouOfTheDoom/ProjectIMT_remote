//
//  Customer.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import Foundation

struct Customer {
    let id: UUID
    var first_name: String
    var last_name: String
    var birthday_date: Date
    
    var transformation_list: [Transformation]
    var number_of_transformations: Int { return transformation_list.count }
    
    init(first_name: String = "", last_name: String = "", birthday_date: Date = Date(), transformation_list: [Transformation] = []) {
        self.id = UUID()
        
        self.first_name = first_name
        self.last_name = last_name
        self.birthday_date = birthday_date
        
        self.transformation_list = transformation_list
    }
}

//this class acts like the ViewModel for the Home page. 
class CustomerData: ObservableObject {
    @Published var customers: [Customer] =
    [
        Customer(first_name: "John", transformation_list: [
            Transformation(name: "Opération du nez"),
            Transformation(name: "Après une visite chez le dermatho"),
            Transformation()]),
        Customer(first_name: "Marc"),
        Customer(first_name: "Marie", transformation_list: [
            Transformation(name: "Dents de sagesses")])
    ]
    
    func addCustomer(first_name: String = "", last_name: String = "", birthday_date: Date = Date()) {
        let customer = Customer(first_name: first_name, last_name: last_name, birthday_date: birthday_date)
        self.customers.append(customer)
    }
    
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
    
    func deleteCustomer(customer_id: UUID) {
        if let index = customers.firstIndex(where: { customer in
            return customer.id == customer_id ? true : false
        }) {
            customers.remove(at: index)
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
}
