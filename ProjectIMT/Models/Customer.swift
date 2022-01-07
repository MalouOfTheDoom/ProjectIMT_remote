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
    var last_name: String?
    var birthday_date: String?
    
    var transformation_list: [Transformation]
    var number_of_transformations: Int { return transformation_list.count }
    
    init(first_name: String, last_name: String? = nil, birthday_date: String? = nil, transformation_list: [Transformation] = []) {
        self.id = UUID()
        
        self.first_name = first_name
        self.last_name = last_name
        self.birthday_date = birthday_date
        
        self.transformation_list = transformation_list
    }
}

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
    
    func deleteTransformation(customer_id: Int, transformation_indexes: IndexSet?) {
        self.customers[customer_id].transformation_list.remove(atOffsets: transformation_indexes!)
    }
}
