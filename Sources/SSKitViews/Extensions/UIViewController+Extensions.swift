//
//  UIViewController+Extensions.swift
//  
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public extension UIViewController {
    
    func add(_ child: UIViewController, containerView: UIView? = nil) {
        addChild(child)
        if let containerView = containerView {
            child.view.frame = containerView.bounds
            containerView.addSubview(child.view)
        } else {
            child.view.frame = view.bounds
            view.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
