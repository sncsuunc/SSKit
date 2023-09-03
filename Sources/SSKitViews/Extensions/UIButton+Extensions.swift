//
//  UIButton+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UIButton {
    
    @IBInspectable
    var localizeTitle: String {
        set(value) {
            self.setTitle(NSLocalizedString(value, comment: ""), for: .normal)
        }
        get {
            return ""
        }
    }
    
}
