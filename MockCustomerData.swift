//
//  MockCustomerData.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 06/01/2022.
//

import Foundation

struct MockCustomerData {
    let customers: [Customer] =
    [
        Customer(first_name: "John", transformation_list: [
            Transformation(name: "arrachage de dent"),
            Transformation(name: "jolie nez"),
            Transformation()]),
        Customer(first_name: "Marc"),
        Customer(first_name: "Marie", transformation_list: [
            Transformation(name: "jolie peau pour Marie")])
    ]
}

