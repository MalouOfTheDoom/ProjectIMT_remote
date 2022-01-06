//
//  Customer.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import Foundation

class Customer: Identifiable {
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
    
    func addTransformation(transformation: Transformation) {
        self.transformation_list.append(transformation)
    }
    
}
