//
//  UILabel+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UILabel {
    
    @IBInspectable
    var isUnderline: Bool {
        set {
            if newValue {
                guard let text = text else { return }
                let textRange = NSRange(location: 0, length: text.count)
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(.underlineStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: textRange)
                self.attributedText = attributedText
            }
        }
        @available(*, unavailable)
        get {
            fatalError("VARIABLE CAN NOT READ.")
        }
    }
    
}

public extension UILabel {
    
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
