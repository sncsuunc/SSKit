//
//  SSViewController.swift
//  
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
        bindViewModel()
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
        
    }
    
    @objc open func initializeViews() {
        
    }
    
    @objc open func initializeData() {
        
    }
    
    @objc open func bindViewModel() {
        
    }
    
    @objc open func reloadSetting() {
        
    }
    
    @objc open func releaseSetting() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
