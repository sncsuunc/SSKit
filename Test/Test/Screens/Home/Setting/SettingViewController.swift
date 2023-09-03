//
//  SettingViewController.swift
//  Test
//
//  Created by SUU on 04/09/2023.
//

import SSKit

class SettingViewController: SSViewController {

    override func initializeViews() {
        super.initializeViews()
        view.backgroundColor = .yellow
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewOnTouch)))
    }
    
    @objc private func viewOnTouch(_ gesture: UITapGestureRecognizer) {
        AppRouter.shared.navigate(to: HomeRoute.root, with: .close(.right))
    }

}
