//
//  UILabel+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

extension UILabel {
    
    public func underline() {
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        self.attributedText = attributedText
    }
    
}

extension UILabel {
    
    @IBInspectable
    public var localizeText: String {
        set(value) {
            self.text = NSLocalizedString(value, comment: "")
        }
        get {
            return ""
        }
    }
    
}
