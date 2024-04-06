//
//  SSTabBarItemView.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit
#if canImport(SSKitCores)
@_exported import SSKitCores
#endif

@IBDesignable
open class SSTabBarItemView: UIView {
    
    var onTouch: (() -> Void)?
    
    @IBInspectable
    open var isSelected: Bool = false {
        didSet {
            if normalImage != nil && selectedImage != nil {
                self.iconView.image = isSelected ? selectedImage : normalImage
            } else {
                self.iconView.tintColor = isSelected ? selectedColor : normalColor
            }
            self.titleView.textColor = isSelected ? selectedColor : normalColor
        }
    }
    
    @IBInspectable
    open var title: String = "" {
        didSet {
            self.titleView.text = title
        }
    }
    
    @IBInspectable
    open var normalImage: UIImage?
    
    @IBInspectable
    open var selectedImage: UIImage?
    
    @IBInspectable
    open var normalColor: UIColor = .white {
        didSet {
            self.titleView.textColor = normalColor
        }
    }
    
    @IBInspectable
    open var selectedColor: UIColor = .black
    
    private var iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.tintColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var titleView: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 11)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }
    
    public convenience init(title: String? = nil, icon: UIImage? = nil, normalColor: UIColor = .lightGray, selectedColor: UIColor = .systemBlue) {
        self.init(frame: CGRect.zero)
        self.titleView.text = title
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        if #available(iOS 13.0, *) {
            iconView.image = icon != nil ? icon : UIImage(systemName: "circle.grid.3x3.fill")
        } else {
            iconView.image = icon
        }
        self.isSelected = false
    }
    
    
    private func initializeView() {
        self.clipsToBounds = false
        self.backgroundColor = .clear
        self.addSubview(self.titleView)
        self.titleView.leadingToSuperview()
        self.titleView.trailingToSuperview()
        self.titleView.bottomToSuperview(offset: 8)
        self.addSubview(self.iconView)
        self.iconView.topToSuperview(offset: 8)
        self.iconView.bottomToTop(of: self.titleView)
        self.iconView.centerXToSuperview()
        self.iconView.height(to: self, multiplier: 0.6, relation: .equalOrLess)
        self.iconView.aspectRatio(1)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnTouch)))
    }
    
    @objc private func viewOnTouch(_ gesture: UITapGestureRecognizer) {
        self.isSelected = true
        self.onTouch?()
    }
    
}

