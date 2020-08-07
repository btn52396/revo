//
//  LabelledImage.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import Foundation

struct LabelledImage: Codable {
    var label: String
    var imageName: String
    
    enum CodingKeys: String, CodingKey {
        case label = "label"
        case imageName = "image_name"
    }
}

