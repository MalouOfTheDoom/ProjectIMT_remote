//
//  Transformation.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import Foundation
import SwiftUI

class Transformation: Identifiable, ObservableObject { //class au lieu de struct a cause de ObservableObject
    let id: UUID
    @Published var name: String?
    @Published var before_picture: Image?
    @Published var after_picture: Image?
    var before_date: String?
    var after_date: String?
    
    init(name: String? = nil) {
        id = UUID()
        self.name = name
    }
}
