//
//  HomeView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct HomeView: View {
//    let john = Customer(first_name: "John")
//    let marc = Customer(first_name: "Marc")
//    let marie = Customer(first_name: "Marie")
    var customers_list = [Customer(first_name: "John"),
                          Customer(first_name: "Marc"),
                          Customer(first_name: "Marie")]
    
    var body: some View {
        List(customers_list) {
            Text($0.first_name)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
