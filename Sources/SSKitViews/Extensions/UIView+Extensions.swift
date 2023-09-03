//
//  UIView+Extensions.swift
//  
//
//  Created by SUU on 04/09/2023.
//

import UIKit

import UIKit

public enum SSConstrainableRelation: Int {
    case equal = 0
    case equalOrLess = -1
    case equalOrGreater = 1
}

public protocol UIViewConstrainable {
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }

    @discardableResult
    func loadConstrainable() -> Self
    
}

extension UIView {
    
    public func isPressed(_ isPressed: Bool) {
        if isPressed {
            let scale: CGFloat = 0.8
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isPressed(false)
                }
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
    }
    
}

extension UIView: UIViewConstrainable {
    
    @discardableResult
    public func loadConstrainable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setHugging(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(priority, for: axis)
    }
    
    func setCompressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(priority, for: axis)
    }
    
}

extension UILayoutGuide: UIViewConstrainable {
    
    @discardableResult
    public func loadConstrainable() -> Self { return self }
    
}

// MARK: SUPERVIEW
public extension UIView {
    
    private func safeConstrainable(for superview: UIView?, usingSafeArea: Bool) -> UIViewConstrainable {
        guard let superview = superview else {
            fatalError("cause it has no superview.")
        }
        
        loadConstrainable()
        
#if os(iOS) || os(tvOS)
        if #available(iOS 11, tvOS 11, *){
            if usingSafeArea {
                return superview.safeAreaLayoutGuide
            }
        }
#endif
        
        return superview
    }
    
    @discardableResult
    func edgesToSuperview(_ insets: UIEdgeInsets = .zero, usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(topToSuperview(offset: insets.top, usingSafeArea: usingSafeArea))
        constraints.append(bottomToSuperview(offset: insets.bottom, usingSafeArea: usingSafeArea))
        constraints.append(leadingToSuperview(offset: insets.left, usingSafeArea: usingSafeArea))
        constraints.append(trailingToSuperview(offset: insets.right, usingSafeArea: usingSafeArea))
        return constraints
    }
    
    @discardableResult
    func topToSuperview( _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> NSLayoutConstraint {
        let constrainable = safeConstrainable(for: superview, usingSafeArea: usingSafeArea)
        return top(to: constrainable, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func bottomToSuperview( _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> NSLayoutConstraint {
        let constrainable = safeConstrainable(for: superview, usingSafeArea: usingSafeArea)
        return bottom(to: constrainable, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func centerXToSuperview( _ anchor: NSLayoutXAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> NSLayoutConstraint {
        let constrainable = safeConstrainable(for: superview, usingSafeArea: usingSafeArea)
        return centerX(to: constrainable, anchor, multiplier: multiplier, offset: offset, priority: priority, isActive: isActive)
    }
    
    @available(tvOS 10.0, *)
    @available(iOS 10.0, *)
    @discardableResult
    func leadingToSuperview( _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> NSLayoutConstraint {
        let constrainable = safeConstrainable(for: superview, usingSafeArea: usingSafeArea)
        
        if effectiveUserInterfaceLayoutDirection == .rightToLeft {
            return leading(to: constrainable, anchor, offset: -offset, relation: relation, priority: priority, isActive: isActive)
        } else {
            return leading(to: constrainable, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
        }
    }
    
    @available(tvOS 10.0, *)
    @available(iOS 10.0, *)
    @discardableResult
    func trailingToSuperview( _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> NSLayoutConstraint {
        let constrainable = safeConstrainable(for: superview, usingSafeArea: usingSafeArea)
        
        if effectiveUserInterfaceLayoutDirection == .rightToLeft {
            return trailing(to: constrainable, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
        } else {
            return trailing(to: constrainable, anchor, offset: -offset, relation: relation, priority: priority, isActive: isActive)
        }
    }
    
    @available(tvOS 10.0, *)
    @available(iOS 10.0, *)
    @discardableResult
    func horizontalToSuperview(insets: UIEdgeInsets = .zero, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        if effectiveUserInterfaceLayoutDirection == .leftToRight {
            constraints.append(leadingToSuperview(offset: insets.left, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
            constraints.append(trailingToSuperview(offset: -insets.right, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
        } else {
            constraints.append(leadingToSuperview(offset: -insets.right, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
            constraints.append(trailingToSuperview(offset: insets.left, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
        }
        
        return constraints
    }
    
    @available(tvOS 10.0, *)
    @available(iOS 10.0, *)
    @discardableResult
    func verticalToSuperview(insets: UIEdgeInsets = .zero, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
        
        let constraints = [NSLayoutConstraint](arrayLiteral:
            topToSuperview(offset: insets.top, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea),
            bottomToSuperview(offset: -insets.bottom, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
        )
        return constraints
    }
    
}

public extension UIView {
    
    @discardableResult
    func center(in view: UIViewConstrainable, offset: CGPoint = .zero, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        let constraints = [
            centerX(to: view, offset: offset.x, priority: priority, isActive: isActive),
            centerY(to: view, offset: offset.y, priority: priority, isActive: isActive)
        ]
        
        return constraints
    }
    
    @discardableResult
    func edges(to view: UIViewConstrainable, insets: UIEdgeInsets = .zero, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(top(to: view, offset: insets.top, relation: relation, priority: priority, isActive: isActive))
        
            constraints.append(leading(to: view, offset: insets.left, relation: relation, priority: priority, isActive: isActive))
            constraints.append(bottom(to: view, offset: -insets.bottom, relation: relation, priority: priority, isActive: isActive))
            constraints.append(trailing(to: view, offset: -insets.right, relation: relation, priority: priority, isActive: isActive))
        return constraints
    }
    
    @discardableResult
    func size(_ size: CGSize, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        let constraints = [
            width(size.width, relation: relation, priority: priority, isActive: isActive),
            height(size.height, relation: relation, priority: priority, isActive: isActive)
        ]
        
        return constraints
    }
    
    @discardableResult
    func size(to view: UIViewConstrainable, multiplier: CGFloat = 1, insets: CGSize = .zero, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        let constraints = [
            width(to: view, multiplier: multiplier, offset: insets.width, relation: relation, priority: priority, isActive: isActive),
            height(to: view, multiplier: multiplier, offset: insets.height, relation: relation, priority: priority, isActive: isActive)
        ]
        
        return constraints
    }
    
    @discardableResult
    func width(_ width: CGFloat, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return widthAnchor.constraint(equalToConstant: width).with(priority).set(isActive)
        case .equalOrLess: return widthAnchor.constraint(lessThanOrEqualToConstant: width).with(priority).set(isActive)
        case .equalOrGreater: return widthAnchor.constraint(greaterThanOrEqualToConstant: width).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func width(to view: UIViewConstrainable, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return widthAnchor.constraint(equalTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return widthAnchor.constraint(lessThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return widthAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        }
    }

    @discardableResult
    func widthToHeight(of view: UIViewConstrainable, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return width(to: view, view.heightAnchor, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func width(min: CGFloat? = nil, max: CGFloat? = nil, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        var constraints: [NSLayoutConstraint] = []
        
        if let min = min {
            let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: min).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        
        if let max = max {
            let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: max).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    @discardableResult
    func height(_ height: CGFloat, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return heightAnchor.constraint(equalToConstant: height).with(priority).set(isActive)
        case .equalOrLess: return heightAnchor.constraint(lessThanOrEqualToConstant: height).with(priority).set(isActive)
        case .equalOrGreater: return heightAnchor.constraint(greaterThanOrEqualToConstant: height).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func height(to view: UIViewConstrainable, _ dimension: NSLayoutDimension? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return heightAnchor.constraint(equalTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return heightAnchor.constraint(lessThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return heightAnchor.constraint(greaterThanOrEqualTo: dimension ?? view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
        }
    }

    @discardableResult
    func heightToWidth(of view: UIViewConstrainable, multiplier: CGFloat = 1, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return height(to: view, view.widthAnchor, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func height(min: CGFloat? = nil, max: CGFloat? = nil, priority: UILayoutPriority = .required, isActive: Bool = true) -> [NSLayoutConstraint] {
        loadConstrainable()
        
        var constraints: [NSLayoutConstraint] = []
        
        if let min = min {
            let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: min).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        
        if let max = max {
            let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: max).with(priority)
            constraint.isActive = isActive
            constraints.append(constraint)
        }
        
        return constraints
    }

    @discardableResult
    func aspectRatio(_ ratio: CGFloat, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        return widthToHeight(of: self, multiplier: ratio, offset: 0, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func leadingToTrailing(of view: UIViewConstrainable, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        return leading(to: view, view.trailingAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func leading(to view: UIViewConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return leadingAnchor.constraint(equalTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return leadingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return leadingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.leadingAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func trailingToLeading(of view: UIViewConstrainable, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        return trailing(to: view, view.leadingAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func trailing(to view: UIViewConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return trailingAnchor.constraint(equalTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return trailingAnchor.constraint(lessThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return trailingAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.trailingAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func topToBottom(of view: UIViewConstrainable, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        return top(to: view, view.bottomAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func top(to view: UIViewConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return topAnchor.constraint(lessThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return topAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.topAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func bottomToTop(of view: UIViewConstrainable, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        return bottom(to: view, view.topAnchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }
    
    @discardableResult
    func bottom(to view: UIViewConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, relation: SSConstrainableRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        switch relation {
        case .equal: return bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrLess: return bottomAnchor.constraint(lessThanOrEqualTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        case .equalOrGreater: return bottomAnchor.constraint(greaterThanOrEqualTo: anchor ?? view.bottomAnchor, constant: offset).with(priority).set(isActive)
        }
    }
    
    @discardableResult
    func centerX(to view: UIViewConstrainable, _ anchor: NSLayoutXAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()
        
        let constraint: NSLayoutConstraint

        if let anchor = anchor {
            constraint = centerXAnchor.constraint(equalTo: anchor, constant: offset).with(priority)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: offset).with(priority)
        }

        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func centerY(to view: UIViewConstrainable, _ anchor: NSLayoutYAxisAnchor? = nil, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
        loadConstrainable()

        let constraint: NSLayoutConstraint

        if let anchor = anchor {
            constraint = centerYAnchor.constraint(equalTo: anchor, constant: offset).with(priority)
        } else {
            constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: offset).with(priority)
        }

        constraint.isActive = isActive
        return constraint
    }
    
}
