//
//  Data+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import Foundation

public extension Data {
    
    func toString() -> String? {
        return String(data: self.base64EncodedData(), encoding: .utf8)
    }
    
    func toBase64() -> String {
        return base64EncodedString()
    }
    
}
