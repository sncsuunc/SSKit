//
//  UILoadingView.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import UIKit

public class UILoadingView {

    internal static var spinner: UIActivityIndicatorView?
    
    public static func show() {
        DispatchQueue.main.asyncSafety {
            NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
            if spinner == nil, let window = UIApplication.shared.windows.first {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                if #available(iOS 13.0, *) {
                    spinner.style = .large
                }
                window.addSubview(spinner)
                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }

    public static func hide() {
        DispatchQueue.main.asyncSafety {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }

    @objc static func update() {
        DispatchQueue.main.asyncSafety {
            if spinner != nil {
                hide()
                show()
            }
        }
    }
    
}
