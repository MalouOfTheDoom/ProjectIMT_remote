//
//  TransformationItem.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct TransformationItemRow: View {
    
    var transformation: Transformation
    
    var body: some View {
        HStack {
            Image(systemName: "photo").imageScale(.large)
            VStack {
                if let name = transformation.name {
                    Text(name) 
                }
                Button("see Transformation!", action: openTransformation)
                Image(systemName: "trash")
            }
            Image(systemName: "photo").imageScale(.large)
        }
    }
    
    func openTransformation() {
        
    }
}

//struct TransformationItem_Previews: PreviewProvider {
//    private var transformation: Transformation = Transformation(name: "remodellage du nez")
//    static var previews: some View {
//        TransformationItemRow(transformation: transformation)
//    }
//}
