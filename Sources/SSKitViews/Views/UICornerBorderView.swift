//
//  UICornerBorderView.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

extension UIBezierPath {
    
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
    
}

extension UIBezierPath {

    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != 0 {
            path.move(to: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y))
        } else {
            path.move(to: topLeft)
        }

        if topRightRadius != 0 {
            path.addLine(to: CGPoint(x: topRight.x - topRightRadius, y: topRight.y))
            path.addArc(tangent1End: topRight, tangent2End: CGPoint(x: topRight.x, y: topRight.y + topRightRadius), radius: topRightRadius)
        }
        else {
            path.addLine(to: topRight)
        }

        if bottomRightRadius != 0 {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - bottomRightRadius))
            path.addArc(tangent1End: bottomRight, tangent2End: CGPoint(x: bottomRight.x - bottomRightRadius, y: bottomRight.y), radius: bottomRightRadius)
        }
        else {
            path.addLine(to: bottomRight)
        }

        if bottomLeftRadius != 0 {
            path.addLine(to: CGPoint(x: bottomLeft.x + bottomLeftRadius, y: bottomLeft.y))
            path.addArc(tangent1End: bottomLeft, tangent2End: CGPoint(x: bottomLeft.x, y: bottomLeft.y - bottomLeftRadius), radius: bottomLeftRadius)
        }
        else {
            path.addLine(to: bottomLeft)
        }

        if topLeftRadius != 0 {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + topLeftRadius))
            path.addArc(tangent1End: topLeft, tangent2End: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y), radius: topLeftRadius)
        }
        else {
            path.addLine(to: topLeft)
        }

        path.closeSubpath()
        cgPath = path
    }
}

@IBDesignable
public class UICornerBorderView: UIView  {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
}

@IBDesignable
public class UICornerBorderShapeView: UIView  {

    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = borderColor.cgColor
        shape.lineWidth = borderWidth * 2.0
        layer.mask = shape
    }
    
    @IBInspectable
    public var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}

@IBDesignable
public class UICornerBorderStackView: UIStackView  {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
}

@IBDesignable
public class UICornerBorderShapeStackView: UIStackView  {

    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = borderColor.cgColor
        shape.lineWidth = borderWidth * 2.0
        layer.mask = shape
    }

    @IBInspectable
    public var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}

@IBDesignable
public class UICornerBorderLabel: UILabel  {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
}

@IBDesignable
public class UICornerBorderShapeLabel: UILabel  {

    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = borderColor.cgColor
        shape.lineWidth = borderWidth
        layer.mask = shape
    }
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    public override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }

    @IBInspectable
    public var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}

@IBDesignable
public class UICornerBorderButton: UIButton  {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
}

@IBDesignable
public class UICornerBorderShapeButton: UIButton  {

    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = borderColor.cgColor
        shape.lineWidth = borderWidth
        layer.mask = shape
    }
    
    @IBInspectable
    public var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
    
}

