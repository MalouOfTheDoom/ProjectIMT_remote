//
//  ShowTransformation.swift
//  ProjectIMT
//
//  Created by Sacha sicoli on 18/01/2022.
//

import SwiftUI

struct ShowTransformationView: View {
    var transformation: Transformation
    
    @State var SliderValue: Double = 0
    var body: some View {
               
        VStack{
            Text(transformation.name!)
            //Text("Before: "+transformation.before_date)
            //Text("After: "+transformation.after_date)
            //Image(transformation.before_picture)
            ZStack {
                Image(uiImage: transformation.before_picture!)
                    .resizable()
                    .scaledToFit()
                    .opacity(SliderValue)
                
                Image(uiImage: transformation.after_picture!)
                    .resizable()
                    .scaledToFit()
                    .opacity(1 - SliderValue)
            }
            
                
            Slider(value: $SliderValue, in: 0...1, step: 0.01)
                .accentColor(.red)
                .padding()
            
        }
    }
}

struct ShowTransformationViewPreviewContainer: View {
    var transformation = Transformation(name: "preview transfo",
                                        before_picture: UIImage(contentsOfFile: "selfie1"),
                                        after_picture: UIImage(contentsOfFile: "selfie2"),
                                        before_date: Date(),
                                        after_date: Date() )
    var body: some View {
        ShowTransformationView(transformation: transformation)
    }
    
}
struct ShowTransformationView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShowTransformationViewPreviewContainer()
    }
}
