//
//  test2.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 07/01/2022.
//

import SwiftUI

struct test2: View {
    @State var compteur = 0
    
    var body: some View {
        VStack {
            Button("click me") {
                self.compteur += 1
            }
            Text(String(compteur))
            Spacer()
            test3(compteur2: $compteur)
        }
    }
}

struct test3: View {
    @Binding var compteur2: Int
    
    var body: some View {
        VStack {
            Button("click me") {
                self.compteur2 += 1
            }
            Text(String(compteur2))
        }
    }
}

struct test2_Previews: PreviewProvider {
    static var previews: some View {
        test2()
    }
}
