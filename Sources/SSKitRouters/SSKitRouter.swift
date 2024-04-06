//
//  SSKitRouter.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

open class SSKitRouter: NSObject, SSRouter {
    
    public var rootViewController: UINavigationController?
    public var currentViewController: UIViewController?
    public var currentTransition: SSRouterTransition?
    
    public required init(with route: SSRoute) {
        let viewController = route.screen
        rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController?.isNavigationBarHidden = true
        currentViewController = viewController
    }
    
}

