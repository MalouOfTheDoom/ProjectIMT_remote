//
//  CustomCameraView.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 04/01/2022.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    var before_picture: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode //deprecated, we could use isPresented or dismiss instead...
    
    var body: some View {
        //GeometryReader { geometry in
            ZStack {
            
                CameraView(cameraService: cameraService) { result in
                    switch result {
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            capturedImage = UIImage(data: data)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            print("Error: no image data found")
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                
                Group {
                    if before_picture != nil {
                        Image(uiImage: before_picture!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            //.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .opacity(0.5)
                        
                    } else {
                        Image("ProportionFaceTemplate")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 400, alignment: .center)
                            .opacity(0.8)
                    }
                }
               
                VStack {
                    Spacer()
                    Button(action: {
                        cameraService.capturePhoto()
                    }, label: {
                        Image(systemName: "circle")
                            .font(.system(size: 72))
                            .foregroundColor(.white)
                    })
                        .padding(.bottom)
                    
                }
            //}
        }
        
    }
}
