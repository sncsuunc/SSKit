//
//  AppRouter.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

class AppRouter: SSKitRouter {
    
    public static let shared = AppRouter()
    
    required init(with route: SSRoute) {
        super.init(with: route)
    }
    
    private init() {
        super.init(with: MainRoute.root)
    }
    
}
