//
//  UITextField+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UITextField {
    
    @IBInspectable
    var localizePlaceholder: String {
        set(value) {
            self.placeholder = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
}

