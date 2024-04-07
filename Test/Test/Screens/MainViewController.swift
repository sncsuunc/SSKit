//
//  MainViewController.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

class MainViewController: SSTabBarController {
    
    override func initializeNotification() {
        
    }
    
    override func initializeViews() {
        let home = HomeRoute.root.screen
        if #available(iOS 13.0, *) {
            home.tabBarItemView = SSTabBarItemView(title: "Home", icon: UIImage(systemName: "house"))
        }
        let profile = ProfileRoute.root.screen
        if #available(iOS 13.0, *) {
            profile.tabBarItemView = SSTabBarItemView(title: "Profile", icon: UIImage(systemName: "person"))
        }
        viewContollers = [home, profile]
        isUsingSafeArea = false
        selectedIndex = 1
        
        let label = UILabel()
        label.text = "VIEW CUSTOM"
        label.textColor = .white
        label.textAlignment = .center
        addViewCustom(label)
        isShowViewCustom = true
    }
    
    override func initializeData() {
        
    }
    
    override func didSelected(index: Int, viewController: SSViewController) {
        AppRouter.shared.rootViewController = viewController.navigationController
        AppRouter.shared.currentViewController = viewController
    }
    
}
