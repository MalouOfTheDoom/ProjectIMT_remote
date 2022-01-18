//
//  ShowTransformation.swift
//  ProjectIMT
//
//  Created by Sacha sicoli on 18/01/2022.
//

import SwiftUI

struct ShowTransformation: View {
    //@Binding var transformation: Transformation
    //@State var showActionSheet: Bool=false
    @State var SliderValue: Double = 100
    var body: some View {
        
        //Button("Exit"){
            //showActionSheet.toggle()
        //}
        //.actionSheet(isPresented: $showActionSheet, content: { ActionSheet(buttons: [ActionSheet.Button = cancel()])
        //.frame(frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: .topLeading)
               
        VStack{
            //Text(transformation.name)
            //Text("Before: "+transformation.before_date)
            //Text("After: "+transformation.after_date)
            //Image(transformation.before_picture)
            Image("esprit")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 160)
                
            Text("Evolution:")
            Text(//"\(SliderValue)")
                String(format: "%.Of", SliderValue))
            Slider(value: $SliderValue, in: 0...100, step: 1)
                .accentColor(.red)
            
        }
    }
}

struct ShowTransformation_Previews: PreviewProvider {
    static var previews: some View {
        ShowTransformation()
    }
}
