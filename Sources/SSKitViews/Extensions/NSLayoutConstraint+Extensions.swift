//
//  NSLayoutConstraint+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension NSLayoutConstraint {
    
    @objc
    func with(_ p: UILayoutPriority) -> Self {
        priority = p
        return self
    }
    
    func set(_ active: Bool) -> Self {
        isActive = active
        return self
    }
    
}

public extension Collection where Iterator.Element == NSLayoutConstraint {
    
    func activate() {
        if let constraints = self as? [NSLayoutConstraint] {
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    func deActivate() {
        if let constraints = self as? [NSLayoutConstraint] {
            NSLayoutConstraint.deactivate(constraints)
        }
    }
    
}
