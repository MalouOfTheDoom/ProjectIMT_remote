//
//  MainView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            OptionsView()
                .tabItem {
                    Label("Options", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
