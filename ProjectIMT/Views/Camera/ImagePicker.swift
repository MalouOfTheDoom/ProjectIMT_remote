//
//  PhotoSelector.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 06/01/2022.
//

import SwiftUI
import UIKit

//Todo: rajouter gestion des erreurs
struct ImagePicker: View {
    @Binding var image: UIImage?
    var before_picture: UIImage?
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        // WARNING: Force wrapped image for demo purpose
        (image != nil ? Image(uiImage: image!) : Image(systemName: "photo.fill"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture { self.shouldPresentActionScheet = true }
                .sheet(isPresented: $shouldPresentImagePicker) {
                    if self.sourceType == .camera {
//                        CustomCameraView(capturedImage: self.$image, before_picture: before_picture)
                        CameraView2(captured_image: self.$image, before_picture: before_picture)
                    }
                    else {
                        SUImagePickerView(image: self.$image, isPresented: self.$shouldPresentImagePicker)
                    }
            }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                ActionSheet(title: Text("Selection Image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                    self.shouldPresentImagePicker = true
                    self.sourceType = .camera
                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                    self.shouldPresentImagePicker = true
                    self.sourceType = .photoLibrary
                }), ActionSheet.Button.cancel()])
        }
    }
    
}

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}

//just for the preview
struct ImagePickerPreview_Container: View {
    @State var image: UIImage? = nil
    var body: some View {
        ImagePicker(image: $image)
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerPreview_Container()
    }
}
