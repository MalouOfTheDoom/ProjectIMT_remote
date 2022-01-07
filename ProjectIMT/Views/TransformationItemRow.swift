//
//  TransformationItem.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct TransformationItemRow: View {
    
    @Binding var transformation: Transformation
    
    var body: some View {
        
        HStack {
            Spacer()
            ImagePicker(image: $transformation.before_picture)
            Spacer()
            VStack {
                if let name = transformation.name {
                    Text(name) 
                }
                Button("see Transformation!", action: openTransformation)
                Image(systemName: "trash")
            }
            Spacer()
            ImagePicker(image: $transformation.after_picture)
            Spacer()
        }
    }
    
    func openTransformation() {
        
    }
}


//just for the preview
struct TransformationItem_Previews: PreviewProvider {
    static var previews: some View {
        TransformationItemPreview_Container()
    }
}

struct TransformationItemPreview_Container: View {
    @State var transformation = Transformation(name: "arrachage de dents")
    var body: some View {
        TransformationItemRow(transformation: $transformation)
    }
}
