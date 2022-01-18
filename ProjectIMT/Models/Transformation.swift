//
//  Transformation.swift
//  ProjectIMT
//
//  Created by Maël Trouillet on 05/01/2022.
//

import Foundation
import SwiftUI

struct Transformation: Identifiable {
    let id: UUID
    var name: String?
    var before_picture: UIImage?
    var after_picture: UIImage?
    var before_date: Date?
    var after_date: Date?
    
    init(name: String? = nil, before_picture: UIImage? = nil, after_picture: UIImage? = nil, before_date: Date? = nil, after_date: Date? = nil) {
        id = UUID()
        self.name = name
        self.before_picture = before_picture
        self.after_picture = after_picture
        self.before_date = before_date
        self.after_date = after_date
    }
}
