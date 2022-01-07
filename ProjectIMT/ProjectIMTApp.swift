//
//  ProjectIMTApp.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

@main
struct ProjectIMTApp: App {
    
    @StateObject var customerData = CustomerData()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(customerData)
        }
    }
}
