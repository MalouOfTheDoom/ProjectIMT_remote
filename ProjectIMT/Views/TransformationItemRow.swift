//
//  TransformationItem.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import SwiftUI

struct TransformationItemRow: View {
    
    @Binding var transformation: Transformation
    @State var transformationSheetIsPresented: Bool = false
    
    var bothImagesTaken : Bool {
        if (transformation.before_picture != nil && transformation.after_picture != nil) {
            return true
        } else {
            return false
        }
    }
    
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
                Button(action: openTransformation ) { label:  do {
                    HStack {
                        Image(systemName: "photo.fill")
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(Color.white)
                        Image(systemName: "photo.fill")
                    }
                }}
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(bothImagesTaken ? Color.red : Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .disabled(!bothImagesTaken)
                    .sheet(isPresented: $transformationSheetIsPresented) {
                        ShowTransformationView(transformation: self.transformation)
                    }
                    
            }
            
            ImagePicker(image: $transformation.after_picture, before_picture: transformation.before_picture)
                .padding(.horizontal)
                .disabled(transformation.before_picture == nil)
        }
    }
    
    func openTransformation() {
        self.transformationSheetIsPresented = true
    }
}


//just for the preview
//not working
#if DEBUG
extension Binding {
    static func mock(_ transformation: Transformation) -> Binding<Transformation> {
        var transformation = transformation
        return Binding<Transformation>(get: {return transformation}, set: {transformation = $0})
    }
}

struct TransformationItem_Previews: PreviewProvider {
    static var previews: some View {
        TransformationItemRow(transformation: .mock(Transformation(name: "arrachage de dents")))
    }
}
#endif

