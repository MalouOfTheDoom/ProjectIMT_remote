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
    @State var isShowingPopover: Bool = false
    
    var body: some View {
               
        VStack{
            
            if transformation.name != nil {
                Text(transformation.name!)
            }
            
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

extension Transformation {
    static func getPreviewTransfo() -> Transformation {
        let transformation = Transformation(name: "preview transfo",
                                            before_picture: UIImage(contentsOfFile: "selfie1"),
                                            after_picture: UIImage(contentsOfFile: "selfie2"),
                                            before_date: Date(),
                                            after_date: Date() )
        return transformation
    }
}

struct ShowTransformationView_Previews: PreviewProvider {
    static var previews: some View {
        ShowTransformationView(transformation: .getPreviewTransfo())
        
    }
}
