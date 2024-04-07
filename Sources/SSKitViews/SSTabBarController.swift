//
//  SSTabBarController.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit
#if canImport(SSKitCores)
@_exported import SSKitCores
#endif

open class SSTabBarController: SSViewController {
    
    private var currentViewController: SSViewController?
    private var currentNavigationController: UINavigationController?
    private var viewContainerCustomHeight: NSLayoutConstraint?
    private var viewContainerTabBarHeight: NSLayoutConstraint?
    private var viewContainerControllerPosition: NSLayoutConstraint?
    private var viewContainerControllerBottom: NSLayoutConstraint?
    
    private var navigationControllers = [UINavigationController]()
    
    private var viewContainerController: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewContainerTabBar: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    private var viewContainerCustom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open var isUsingSafeArea: Bool = true
    
    open var isShowViewCustom: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.viewContainerCustomHeight?.constant = self.isShowViewCustom ? self.viewCustomHeight : 0
                self.viewContainerCustom.isHidden = !self.isShowViewCustom
                self.setNeedsFocusUpdate()
            }
        }
    }
    
    open var viewCustomColor: UIColor = .clear
    
    open var viewCustomHeight: CGFloat = 50
    
    open var viewTabBarHeight: CGFloat = 56
    
    open var viewContollers = [SSViewController]() {
        didSet {
            initializeViewControllers()
        }
    }
    
    open var selectedIndex: Int = -1 {
        didSet {
            if selectedIndex < 0 || selectedIndex > viewContollers.count {
                fatalError("ViewControllers: Index out of bounds.")
            }
            if selectedIndex != oldValue {
                if viewContollers.count > 0 && viewContollers.count > oldValue  {
                    if oldValue >= 0 {
                        viewContollers[oldValue].tabBarItemView?.isSelected = false
                    }
                    didSelected(index: selectedIndex, viewController: viewContollers[selectedIndex])
                    loadViewControllers()
                }
            }
            if viewContollers.count > 0 && viewContollers.count > selectedIndex  {
                viewContollers[selectedIndex].tabBarItemView?.isSelected = true
            }
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initializeTabBarItems()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension SSTabBarController {
    
    private func initializeTabBarItems() {
        viewContainerCustom.backgroundColor = viewCustomColor
        self.view.addSubview(viewContainerCustom)
        viewContainerCustom.leadingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerCustom.trailingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerCustom.bottomToSuperview(usingSafeArea: true)
        viewContainerCustom.isHidden = !isShowViewCustom
        viewContainerCustomHeight = viewContainerCustom.height(isShowViewCustom ? viewCustomHeight : 0)
        self.view.addSubview(viewContainerTabBar)
        viewContainerTabBar.leadingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerTabBar.trailingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerTabBar.bottomToTop(of: viewContainerCustom)
        viewContainerTabBarHeight = viewContainerTabBar.height(viewTabBarHeight)
        self.view.addSubview(viewContainerController)
        viewContainerController.leadingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerController.trailingToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerController.topToSuperview(usingSafeArea: isUsingSafeArea)
        viewContainerControllerPosition = viewContainerController.bottomToSuperview(priority: .defaultLow, usingSafeArea: isUsingSafeArea)
        viewContainerControllerPosition?.isActive = false
        viewContainerControllerBottom = viewContainerController.bottomToTop(of: viewContainerTabBar)
        viewContainerControllerBottom?.isActive = true
        
    }
 
    private func initializeViewControllers() {
        for (index, controller) in self.viewContollers.enumerated() {
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.delegate = self
            navigationController.isNavigationBarHidden = controller.isNavigationBarHiden
            self.navigationControllers.append(navigationController)
            if let barItem = controller.tabBarItemView {
                self.viewContainerTabBar.addArrangedSubview(barItem)
                barItem.isSelected = false
                barItem.onTouch = {
                    DispatchQueue.main.asyncSafety {
                        self.selectedIndex = index
                        self.didSelected(index: self.selectedIndex, viewController: controller)
                    }
                }
            } else {
                var image: UIImage?
                if #available(iOS 13.0, *) {
                    image = UIImage(systemName: "\(index + 1).circle")
                }
                let barItem = SSTabBarItemView(title: "Item \(index + 1)", icon: image)
                controller.tabBarItemView = barItem
                self.viewContainerTabBar.addArrangedSubview(barItem)
                barItem.isSelected = false
                barItem.onTouch = {
                    DispatchQueue.main.asyncSafety {
                        self.selectedIndex = index
                        self.didSelected(index: self.selectedIndex, viewController: controller)
                    }
                }
            }
        }
        self.selectedIndex = 0
        self.didSelected(index: self.selectedIndex, viewController: self.viewContollers[0])
    }
    
    private func loadViewControllers() {
        let selectedViewController: UINavigationController = navigationControllers[selectedIndex]
        self.addChild(selectedViewController)
        selectedViewController.view.frame = viewContainerController.bounds
        viewContainerController.addSubview(selectedViewController.view)
        selectedViewController.didMove(toParent: self)
        self.currentNavigationController?.remove()
        self.currentNavigationController = selectedViewController
    }
    
}

extension SSTabBarController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController != navigationController.viewControllers.first {
            UIView.animate(withDuration: 0.15) {
                self.viewContainerTabBar.isHidden = true
                self.viewContainerTabBarHeight?.constant = 0
                if self.isUsingSafeArea {
                    self.viewContainerControllerPosition?.isActive = false
                    self.viewContainerControllerBottom?.isActive = true
                } else {
                    self.viewContainerControllerPosition?.isActive = true
                    self.viewContainerControllerBottom?.isActive = false
                }
                self.view.layoutIfNeeded()
            }
        } else {
            self.viewContainerControllerPosition?.isActive = false
            self.viewContainerControllerBottom?.isActive = true
            self.viewContainerTabBarHeight?.constant = 56
            self.viewContainerTabBar.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == navigationController.viewControllers.first {
            self.viewContainerControllerPosition?.isActive = false
            self.viewContainerControllerBottom?.isActive = true
            self.viewContainerTabBar.isHidden = false
            self.viewContainerTabBarHeight?.constant = 56
            self.view.layoutIfNeeded()
        }
    }
    
}

extension SSTabBarController {
    
    @objc open func didSelected(index: Int, viewController: SSViewController) {
        preconditionFailure("This method must be overridden")
    }
    
    @objc open func addViewCustom(_ view: UIView) {
        self.viewContainerCustom.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingToSuperview()
        view.topToSuperview()
        view.trailingToSuperview()
        view.bottomToSuperview()
    }
    
}
