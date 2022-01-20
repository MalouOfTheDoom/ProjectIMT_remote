//
//  MainView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        HomeView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(CustomerData())
    }
}
