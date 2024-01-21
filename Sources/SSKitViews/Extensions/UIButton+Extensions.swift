//
//  UIButton+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UIButton {
    
    @IBInspectable
    var isUnderline: Bool {
        set {
            if newValue {
                guard let text = title(for: .normal) else { return }
                let textRange = NSRange(location: 0, length: text.count)
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(.underlineStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: textRange)
                self.setAttributedTitle(attributedText, for: .normal)
            }
        }
        @available(*, unavailable)
        get {
            fatalError("VARIABLE CAN NOT READ.")
        }
    }
    
}


public extension UIButton {
    
    @IBInspectable
    var localizedTitle: String {
        set {
            self.setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
        }
        get {
            return NSLocalizedString(title(for: .normal) ?? "", comment: "")
        }
    }
    
}
