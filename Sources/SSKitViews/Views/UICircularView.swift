//
//  UICircularView.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public class UICircularView: UIView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
}

public class UICircularButton: UIButton {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
}

public class UICircularImageView: UIButton {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
}
