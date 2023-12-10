//
//  UIButton+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

extension UIButton {
    
    public func underline() {
        guard let text = title(for: .normal) else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        self.setAttributedTitle(attributedText, for: .normal)
    }
    
}


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
