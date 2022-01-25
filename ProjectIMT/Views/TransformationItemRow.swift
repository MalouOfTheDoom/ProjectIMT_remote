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
    @State var cantOpenTransformationAlertIsPresented: Bool = false
    
    //used in the View to display different situations
    var bothImagesTaken : Bool {
        if (transformation.before_picture != nil && transformation.after_picture != nil) {
            return true
        }
        return false
        
    }
    
    //MARK: VIEW
    var body: some View {
        
        HStack {
            //ImagePicker before
            ImagePicker(image: $transformation.before_picture,
                        date: $transformation.before_date)
                .padding(.horizontal)
            
            VStack(spacing: 4) {
                
                //transformation name
                if let name = transformation.name {
                    Text(name)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                //show transformation button
                Button(action: openTransformation ) { label:  do {
                    HStack {
                        
                        DateIfPicturePresent(picture: transformation.before_picture,
                                             date: transformation.before_date)
                        
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 15.0))
                        
                        DateIfPicturePresent(picture: transformation.after_picture,
                                             date: transformation.after_date)
                    }
                }}
                .frame(maxWidth: .infinity)
                .padding()
                .background(bothImagesTaken ? Color.red : Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .alert("Veuillez selectionner des photos avant de voir la transformation", isPresented: $cantOpenTransformationAlertIsPresented) {
                    Button("OK", role: .cancel) { }
                }
                .sheet(isPresented: $transformationSheetIsPresented) {
                    ShowTransformationView(transformation: self.transformation)
                }
                
            }
            
            //ImagePicker after
            ImagePicker(image: $transformation.after_picture,
                        date: $transformation.after_date,
                        before_picture: transformation.before_picture)
                .padding(.horizontal)
                .disabled(transformation.before_picture == nil)
        }
    }
    
    //MARK: VIEW FUNCTIONS
    func DateIfPicturePresent(picture: UIImage?, date: Date?) -> some View {
        Group {
            if (picture != nil && date != nil) {
                Text(date!.jourEtMois)
                    .foregroundColor(Color.white)
                    .font(.system(size: 15.0))
            } else {
                Image(systemName: "photo.fill")
                    .font(.system(size: 20.0))
            }
        }
    }
    
    //MARK: VIEWMODEL FUNCTIONS
    func openTransformation() {
        if bothImagesTaken {
            self.transformationSheetIsPresented = true
        } else {
            self.cantOpenTransformationAlertIsPresented = true
        }
        
    }
}

//MARK: UTILITARIES
extension Formatter {
    static let jourEtMois: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd")
        return dateFormatter
    }()
}

extension Date {
    var jourEtMois: String { Formatter.jourEtMois.string(from: self) }
}


//not working
#if DEBUG
struct TransformationItemRow_Previews: PreviewProvider {
  static var previews: some View {
    PreviewWrapper()
  }

  struct PreviewWrapper: View {
      @State var transformation = Transformation(name: "lifting")

    var body: some View {
      TransformationItemRow(transformation: $transformation)
    }
  }
}
#endif

