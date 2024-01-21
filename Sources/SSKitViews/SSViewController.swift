//
//  SSViewController.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit
#if canImport(SSKitCores)
@_exported import SSKitCores
#endif

open class SSViewController: UIViewController {
    
    open var tabBarItemView: SSTabBarItemView? = nil
    open var isNavigationBarHiden: Bool = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initializeNotification()
        initializeViews()
        initializeData()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadSetting()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        releaseSetting()
    }
    
    @objc open func initializeNotification() {
        preconditionFailure("This method must be overridden")
    }
    
    @objc open func initializeViews() {
        preconditionFailure("This method must be overridden")
    }
    
    @objc open func initializeData() {
        preconditionFailure("This method must be overridden")
    }
    
    @objc open func reloadSetting() {
        preconditionFailure("This method must be overridden")
    }
    
    @objc open func releaseSetting() {
        preconditionFailure("This method must be overridden")
    }
    
}
