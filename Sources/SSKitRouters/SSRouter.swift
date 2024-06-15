//
//  SSKitRouter.swift
//  SSKit
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

public enum SSRouterTransitionFrom: Equatable {
    case right
    case left
    case top
    case bottom
}

public enum SSRouterTransitionStyle: Equatable {
    case formSheet
    case pageSheet
    case fullScreen
    case overFullScreen
    case currentContext
    case overCurrentContext
    case popover
}

public enum SSRouterTransition: Equatable {
    case present(_ from: SSRouterTransitionFrom = .bottom, _ style: SSRouterTransitionStyle = .fullScreen)
    case open(_ from: SSRouterTransitionFrom)
    case push
    case root
    case reset
}

public protocol SSRouter: AnyObject {
    
    var lastTransition: SSRouterTransition? { get set }
    
    var currentTransition: SSRouterTransition? { get set }
    
    var rootViewController: UINavigationController? { get set }
    
    var currentViewController: UIViewController? { get set }
    
    init(with route: SSRoute)
    
    func navigate(root: UINavigationController?, to route: SSRoute, with transition: SSRouterTransition, animated: Bool, completion: (() -> Void)?)
    
    func navigate(to router: SSRouter, animated: Bool, completion: (() -> Void)?)
    
    func exit(_ animated: Bool,_ completion: (() -> Void)?)
    
    func pop(to index: Int, animated: Bool)
    
}

public extension SSRouter {
    
    func navigate(root navigation: UINavigationController? = nil, to route: SSRoute, with transition: SSRouterTransition, animated: Bool = true, completion: (() -> Void)? = nil) {
        lastTransition = currentTransition
        currentTransition = transition
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
                transition.isRemovedOnCompletion = true
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .left:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.isRemovedOnCompletion = true
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .top:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromBottom
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.isRemovedOnCompletion = true
                currentViewController?.view.window?.layer.add(transition, forKey: kCATransition)
            case .bottom:
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.isRemovedOnCompletion = true
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
            currentViewController = viewController
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
    
    func exit(_ animated: Bool = true,_ completion: (() -> Void)? = nil) {
        switch self.currentTransition {
        case .present:
            dismiss(animated, completion)
            break
        case .open(let transition):
            switch transition {
            case .right:
                rootViewController?.close(to: .fromLeft)
            case .left:
                rootViewController?.close(to: .fromRight)
            case .top:
                rootViewController?.close(to: .fromBottom)
            case .bottom:
                rootViewController?.close(to: .fromTop)
            }
            currentViewController = rootViewController?.topViewController
            completion?()
            break
        case .push:
            pop(animated)
            completion?()
            break
        default:
            break
        }
        currentTransition = lastTransition
    }
    
    func pop(to index: Int = 0, animated: Bool = true) {
        if currentTransition != .push {
            return
        }
        if index < 0 {
            rootViewController?.popToRootViewController(animated: animated)
            return
        }
        guard
            let viewControllers = rootViewController?.viewControllers,
            viewControllers.count > index
            else { return }
        let viewController = viewControllers[index]
        rootViewController?.popToViewController(viewController, animated: animated)
        currentViewController = viewController
    }
    
}

extension SSRouter {
    
    private func pop(_ animated: Bool = true) {
        guard
            let viewControllers = rootViewController?.viewControllers,
            !viewControllers.isEmpty
            else { return }
        rootViewController?.popViewController(animated: animated)
        currentViewController = rootViewController?.topViewController
    }
    
    private func dismiss(_ animated: Bool = true,_ completion: (() -> Void)? = nil) {
        let presentingViewController = currentViewController?.presentingViewController
        currentViewController?.dismiss(animated: animated, completion: completion)
        currentViewController = presentingViewController
    }
    
    private func close(_ animated: Bool = true,_ completion: (() -> Void)? = nil) {
        rootViewController?.dismiss(animated: animated, completion: completion)
        currentViewController = rootViewController?.topViewController
    }
    
}
