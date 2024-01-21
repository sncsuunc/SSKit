//
//  ProfileUpdateViewController.swift
//  Test
//
//  Created by SUU on 18/01/2024.
//

import SSKit

class ProfileUpdateViewController: SSViewController {

    override func initializeViews() {
        super.initializeViews()
        view.backgroundColor = .green
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnTouch)))
    }
    
    @objc private func viewOnTouch(_ gesture: UITapGestureRecognizer) {
        AppRouter.shared.popToRoot()
    }
    
}
