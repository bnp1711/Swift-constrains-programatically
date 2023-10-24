//
//  Extension+color.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 20/10/23.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
      return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    // Background Color
    static let mylightGray = rgb(red: 242, green: 242, blue: 247)
}
