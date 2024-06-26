//
//  HomeViewController.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

class HomeViewController: SSViewController {
    
    override func initializeNotification() {
        
    }

    override func initializeViews() {
        view.backgroundColor = .red
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnTouch)))
    }
    
    override func initializeData() {
        
    }
    
    @objc private func viewOnTouch(_ gesture: UITapGestureRecognizer) {
        AppRouter.shared.navigate(to: SettingRoute.root, with: .push)
    }

}
