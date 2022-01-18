//
//  CameraView2.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 18/01/2022.
//

import SwiftUI
import AVFoundation

struct CameraView2: View {
    
    @Binding var captured_image: UIImage?
    
    var body: some View {
        CameraViewWithModel(captured_image: $captured_image, camera: CameraModel(captured_image: $captured_image))
    }
}

struct CameraViewWithModel: View {
    
    @Binding var captured_image: UIImage?
    
    @StateObject var camera : CameraModel
    
    @Environment(\.presentationMode) private var presentationMode //deprecated, we could use isPresented or dissmiss instead...
    
    var body: some View {
        
        ZStack {
            
            // Camera preview
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                if camera.isTaken {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {camera.reTake()}, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                            .padding(.trailing, 10)
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    // if taken showing save and again take button ...
                    
                    if camera.isTaken {
                        
                        Button(action: {
                            camera.savePic()
                            presentationMode.wrappedValue.dismiss()
                            
                        }, label: {
                            Text("save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                            .padding(.leading)
                        
                        Spacer()
                        
                    } else {
                        
                        Button(action: camera.takePic, label: {
                            
                            ZStack {
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                        
                    }
                }.frame(height: 75)
            }
        }
        .onAppear {
            camera.check()
        }
        
    }
}

// Camera Model ...

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
     
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    //sice we are going to read pic data
    @Published var output = AVCapturePhotoOutput()
    
    //preview
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    //Pic data
    @Binding var captured_image: UIImage?
    //@Published var picData = Data(count: 0)
    
    init(captured_image: Binding<UIImage?>) {
        self._captured_image = captured_image
    }
    
    func bind(toBind: UIImage?) {
        self.captured_image = toBind
    }
    
    func check() {
        
        // first checking camera got permission ...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
            // Setting Up Session
        case .notDetermined:
            //retesting for permission ...
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp() {
        
        // setting up camera ...
        
        do {
            
            // setting config ...
            self.session.beginConfiguration()
            
            // change for your own
            //let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            if let device = AVCaptureDevice.default(for: .video) {
                let input = try AVCaptureDeviceInput(device: device)
                
                //checking and adding to session ...
                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }
                
                // same for output ...
                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //take and retake functions...
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            
            /*
             moved inside photoOutput to prevent a bug where the session is closed before the picture could be taken...
             */
            //self.session.stopRunning()
            
            
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
            }
        }
    }
    
    
    func reTake() {
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation { self.isTaken.toggle() }
                
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            return
        }
        print("pic taken...")
        
        if let data = photo.fileDataRepresentation() {
            self.captured_image = UIImage(data: data)
        } else {
            print("Error: no image data found")
        }
        
        self.session.stopRunning()
        
    }
    
    func savePic() {
        
        //let image = UIImage(data: self.picData)!
        
        //saving image ...
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        print("saved successfuly")
    }
}

// setting view preview ...
struct CameraPreview: UIViewRepresentable {

    @ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)

        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame

        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)

        // starting session
        camera.session.startRunning()

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

}


//struct CameraView2_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView2()
//    }
//}
