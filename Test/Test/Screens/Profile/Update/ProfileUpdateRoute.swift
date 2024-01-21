//
//  ProfileUpdateRoute.swift
//  Test
//
//  Created by SUU on 18/01/2024.
//

import SSKit

enum ProfileUpdateRoute: SSRoute {
    
    case root
    
    var screen: SSViewController {
        switch self {
        case .root:
            return ProfileUpdateViewController()
        }
    }
    
}
