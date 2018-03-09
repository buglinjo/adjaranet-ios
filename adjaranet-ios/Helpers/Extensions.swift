//
//  Extensions.swift
//  adjaranet-ios
//
//  Created by Irakli Tchitadze on 3/7/18.
//  Copyright © 2018 Buglinjo. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
}

extension String {
    func titleCase() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func titleCase() {
        self = self.titleCase()
    }
    
    func lowerCase() -> String {
        return lowercased()
    }
}

