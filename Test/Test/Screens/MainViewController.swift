//
//  MainViewController.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

class MainViewController: SSTabBarController {
    
    override func initializeViews() {
        super.initializeViews()
        let home = HomeRoute.root.screen
        if #available(iOS 13.0, *) {
            home.tabBarItemView = SSTabBarItemView(title: "Home", icon: UIImage(systemName: "house"))
        }
        let profile = ProfileRoute.root.screen
        if #available(iOS 13.0, *) {
            profile.tabBarItemView = SSTabBarItemView(title: "Profile", icon: UIImage(systemName: "person"))
        }
        viewContollers = [home, profile]
        isHideViewCustom = true
        selectedIndex = 1
    }
    
    override func initializeData() {
        
    }
    
    override func reloadSetting() {
        
    }
    
    override func releaseSetting() {
        
    }
    
    override func didSelected(index: Int, viewController: SSViewController) {
        AppRouter.shared.rootViewController = viewController.navigationController
        AppRouter.shared.currentViewController = viewController
    }
    
}
