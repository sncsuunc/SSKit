//
//  DispatchQueue+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import Foundation

public extension DispatchQueue {
    
    func asyncSafety(_ closure: @escaping () -> Void) {
        guard self === DispatchQueue.main && Thread.isMainThread else {
            DispatchQueue.main.async(execute: closure)
            return
        }
        closure()
    }
    
}
