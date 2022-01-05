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
    
    var transformations_list: [Transformation]
    var number_of_transformations: Int { return transformations_list.count }
    
    init(first_name: String, last_name: String? = nil, birthday_date: String? = nil) {
        self.id = UUID()
        
        self.first_name = first_name
        self.last_name = last_name
        self.birthday_date = birthday_date
        
        self.transformations_list = []
    }
    
    func addTransformation(transformation: Transformation) {
        self.transformations_list.append(transformation)
    }
    
}
