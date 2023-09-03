//
//  SSKitRouter.swift
//  
//
//  Created by SUU on 04/09/2023.
//

import UIKit
#if canImport(SSKitCores)
@_exported import SSKitCores
#endif
#if canImport(SSKitViews)
@_exported import SSKitViews
#endif

public protocol SSRoute {
    
    var screen: SSViewController { get }
    
}

public enum SSRouterTransitionFrom {
    case right
    case left
    case top
    case bottom
}

public enum SSRouterTransitionStyle {
    case formSheet
    case pageSheet
    case fullScreen
    case overFullScreen
    case currentContext
    case overCurrentContext
    case popover
}

public enum SSRouterTransition {
    case present(_ from: SSRouterTransitionFrom = .bottom, _ style: SSRouterTransitionStyle = .fullScreen)
    case open(_ from: SSRouterTransitionFrom)
    case close(_ to: SSRouterTransitionFrom)
    case push
    case reset
    case root
}

public protocol SSRouter: AnyObject {
    
    var rootViewController: UINavigationController? { get set }
    
    var currentViewController: UIViewController? { get set }
    
    init(with route: SSRoute)
    
    func navigate(root: UINavigationController?, to route: SSRoute, with transition: SSRouterTransition, animated: Bool, completion: (() -> Void)?)
    
    func navigate(to router: SSRouter, animated: Bool, completion: (() -> Void)?)
    
    func pop(_ animated: Bool)
    
    func pop(to index: Int, animated: Bool)
    
    func popToRoot(_ animated: Bool)
    
    func dismiss(_ animated: Bool,_ completion: (() -> Void)?)
    
    func close(_ animated: Bool,_ completion: (() -> Void)?)
    
}

public extension SSRouter {
    
    func navigate(root navigation: UINavigationController? = nil, to route: SSRoute, with transition: SSRouterTransition, animated: Bool = true, completion: (() -> Void)? = nil) {
        let viewController = route.screen
        switch transition {
        case let .present(from, style):
            switch from {
            case .right:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .left:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .top:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .bottom:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromBottom
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            }
            switch style {
            case .formSheet:
                viewController.modalPresentationStyle = .formSheet
            case .pageSheet:
                viewController.modalPresentationStyle = .pageSheet
            case .fullScreen:
                viewController.modalPresentationStyle = .fullScreen
            case .overFullScreen:
                viewController.modalPresentationStyle = .overFullScreen
            case .currentContext:
                viewController.modalPresentationStyle = .currentContext
            case .overCurrentContext:
                viewController.modalPresentationStyle = .overCurrentContext
            case .popover:
                viewController.modalPresentationStyle = .popover
            }
            currentViewController?.present(viewController, animated: animated, completion: completion)
            currentViewController = viewController
        case .push:
            if let navigation = navigation {
                rootViewController = navigation
                navigation.pushViewController(viewController, animated: animated)
            } else {
                rootViewController?.pushViewController(viewController, animated: animated)
            }
            currentViewController = viewController
        case .reset:
            rootViewController?.setViewControllers([viewController], animated: animated)
            currentViewController = viewController
        case .root:
            let navigationController = UINavigationController(rootViewController: viewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            rootViewController = navigationController
            rootViewController?.isNavigationBarHidden = true
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            currentViewController = viewController
            navigationController.view.alpha = 0
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                navigationController.view.alpha = 1.0
            })
        case let .open(from):
            switch from {
            case .right:
                rootViewController?.open(viewController: viewController, from: .fromRight)
            case .left:
                rootViewController?.open(viewController: viewController, from: .fromLeft)
            case .top:
                rootViewController?.open(viewController: viewController, from: .fromTop)
            case .bottom:
                rootViewController?.open(viewController: viewController, from: .fromBottom)
            }
        case let .close(to):
            switch to {
            case .right:
                rootViewController?.close(to: .fromLeft)
            case .left:
                rootViewController?.close(to: .fromRight)
            case .top:
                rootViewController?.close(to: .fromBottom)
            case .bottom:
                rootViewController?.close(to: .fromTop)
            }
        }
    }
    
    func navigate(to router: SSRouter, animated: Bool, completion: (() -> Void)?) {
        guard let viewController = router.rootViewController else {
            assert(false, "Router does not have a root view controller")
            return
        }
        
        currentViewController?.present(viewController, animated: animated, completion: completion)
        currentViewController = viewController
    }
    
    func popToRoot(_ animated: Bool = true) {
        rootViewController?.popToRootViewController(animated: animated)
    }
    
    func pop(to index: Int, animated: Bool = true) {
        guard
            let viewControllers = rootViewController?.viewControllers,
            viewControllers.count > index
            else { return }
        let viewController = viewControllers[index]
        rootViewController?.popToViewController(viewController, animated: animated)
        currentViewController = viewController
    }
    
    func pop(_ animated: Bool = true) {
        guard
            let viewControllers = rootViewController?.viewControllers,
            !viewControllers.isEmpty
            else { return }
        rootViewController?.popViewController(animated: animated)
        currentViewController = rootViewController?.topViewController
    }
    
    func dismiss(_ animated: Bool = true,_ completion: (() -> Void)? = nil) {
        let presentingViewController = currentViewController?.presentingViewController
        currentViewController?.dismiss(animated: animated, completion: completion)
        currentViewController = presentingViewController
    }
    
    func close(_ animated: Bool = true,_ completion: (() -> Void)? = nil) {
        rootViewController?.dismiss(animated: animated, completion: completion)
        currentViewController = rootViewController?.topViewController
    }
    
}
