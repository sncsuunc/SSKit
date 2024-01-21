//
//  UITextField+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UITextField {
    
    @IBInspectable
    var localizedPlaceholder: String {
        set(value) {
            self.placeholder = NSLocalizedString(value, comment: "")
        }
        get {
            NSLocalizedString(self.placeholder ?? "", comment: "")
        }
    }
    
    @IBInspectable
    var localizedText: String {
        set(value) {
            self.text = NSLocalizedString(value, comment: "")
        }
        get {
            NSLocalizedString(self.text ?? "", comment: "")
        }
    }
    
}

