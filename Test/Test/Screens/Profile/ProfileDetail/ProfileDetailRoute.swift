//
//  ProfileDetailRoute.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

enum ProfileDetailRoute: SSRoute {
    
    case root
    
    var screen: SSViewController {
        switch self {
        case .root:
            return ProfileDetailViewController()
        }
    }
    
}
