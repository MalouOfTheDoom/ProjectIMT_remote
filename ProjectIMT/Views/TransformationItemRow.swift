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
            ImagePicker(image: $transformation.before_picture)
                .padding(.horizontal)
            
            VStack(spacing: 4) {
                if let name = transformation.name {
                    Text(name)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                Button(action: openTransformation) { label:  do {
                    HStack {
                        Image(systemName: "photo.fill")
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(Color.white)
                        Image(systemName: "photo.fill")
                    }
                }}
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
            
            ImagePicker(image: $transformation.after_picture, before_picture: transformation.before_picture)
                .padding(.horizontal)
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
