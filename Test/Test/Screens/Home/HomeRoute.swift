//
//  HomeRoute.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

enum HomeRoute: SSRoute {
    
    case root
    
    var screen: SSViewController {
        switch self {
        case .root:
            return HomeViewController()
        }
    }
    
}
