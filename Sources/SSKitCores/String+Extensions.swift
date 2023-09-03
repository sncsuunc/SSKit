//
//  File.swift
//  
//
//  Created by SUU on 04/09/2023.
//

import Foundation
 
public extension String {
    
    func trimingLeadingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }
        
        return String(self[index...])
    }
    
}

public extension String {
    
    func trimingTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        guard let index = lastIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: characterSet) }) else {
            return self
        }
        
        return String(self[...index])
    }
    
}

public extension String {
    
    func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
    
}

public extension String {
    
    func toInt() -> Int {
        return (self as NSString).integerValue
    }
    
    func toFloat() -> Float {
        return (self as NSString).floatValue
    }
    
    func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
}

public extension String {
    
    func toDictionary() -> [String: AnyHashable]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyHashable]
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}
