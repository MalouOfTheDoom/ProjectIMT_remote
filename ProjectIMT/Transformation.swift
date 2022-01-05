//
//  Transformation.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import Foundation
import SwiftUI

struct Transformation {
    let id: UUID
    var name: String?
    var before_picture: Image?
    var after_picture: Image?
    var before_date: String?
    var after_date: String?
    
    init() {
        id = UUID()
    }
}
