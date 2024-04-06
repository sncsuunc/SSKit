//
//  ProfileUpdateViewController.swift
//  Test
//
//  Created by SUU on 18/01/2024.
//

import SSKit

class ProfileUpdateViewController: SSViewController {

    override func initializeNotification() {
        
    }
    
    override func initializeViews() {
        view.backgroundColor = .green
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnTouch)))
    }
    
    override func initializeData() {
        
    }
    
    @objc private func viewOnTouch(_ gesture: UITapGestureRecognizer) {
        AppRouter.shared.pop(to: -1)
    }
    
}
