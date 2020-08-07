//
//  UIColorExtension.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/3/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
    
    public class var dim: UIColor {
        return UIColor(r: 91, g: 14, b: 13)
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
