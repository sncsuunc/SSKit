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
    private var viewContainerTabBarCustomHeight: NSLayoutConstraint?
    private var viewContainerTabBarHeight: NSLayoutConstraint?
    
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
        view.spacing = 8
        return view
    }()
    
    private var viewContainerTabBarCustom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open var viewContollers = [SSViewController]() {
        didSet {
            initializeViewControllers()
        }
    }
    
    open var isHideViewCustom: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.viewContainerTabBarCustomHeight?.constant = self.isHideViewCustom ? 0 : 56
                self.viewContainerTabBarCustom.isHidden = self.isHideViewCustom
                self.setNeedsFocusUpdate()
            }
        }
    }
    
    open var selectedIndex: Int = -1 {
        didSet {
            if selectedIndex < 0 || selectedIndex > viewContollers.count {
                fatalError("ViewController index out of bounds.")
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
        self.view.addSubview(viewContainerTabBarCustom)
        viewContainerTabBarCustom.leadingToSuperview(usingSafeArea: true)
        viewContainerTabBarCustom.trailingToSuperview(usingSafeArea: true)
        viewContainerTabBarCustom.bottomToSuperview(usingSafeArea: true)
        viewContainerTabBarCustomHeight = viewContainerTabBarCustom.height(isHideViewCustom ? 0 : 50)
        self.view.addSubview(viewContainerTabBar)
        viewContainerTabBar.leadingToSuperview(usingSafeArea: true)
        viewContainerTabBar.trailingToSuperview(usingSafeArea: true)
        viewContainerTabBar.bottomToTop(of: viewContainerTabBarCustom)
        viewContainerTabBarHeight = viewContainerTabBar.height(56)
        self.view.addSubview(viewContainerController)
        viewContainerController.leadingToSuperview(usingSafeArea: true)
        viewContainerController.trailingToSuperview(usingSafeArea: true)
        viewContainerController.topToSuperview(usingSafeArea: true)
        viewContainerController.bottomToTop(of: viewContainerTabBar)
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
                self.view.layoutIfNeeded()
            }
        } else {
            self.viewContainerTabBar.isHidden = false
            self.viewContainerTabBarHeight?.constant = 56
            self.view.layoutIfNeeded()
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == navigationController.viewControllers.first {
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
    
}
