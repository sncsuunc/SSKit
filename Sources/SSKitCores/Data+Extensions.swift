//
//  Data+Extensions.swift
//  SSKit
//
//  Created by SUU on 04/09/2023.
//

import Foundation
import CommonCrypto

public extension Data {
    
    func toString() -> String? {
        return String(data: self.base64EncodedData(), encoding: .utf8)
    }
    
    func toBase64() -> String {
        return base64EncodedString()
    }
    
    func aesEncrypt(key: Data, iv: Data) -> Data? {
        let bufferSize = count + kCCBlockSizeAES128
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        var numBytesEncrypted = 0

        let cryptStatus = key.withUnsafeBytes { keyBytes in
            iv.withUnsafeBytes { ivBytes in
                withUnsafeBytes { dataBytes in
                    CCCrypt(
                        CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, key.count,
                        ivBytes.baseAddress,
                        dataBytes.baseAddress, count,
                        &buffer,
                        bufferSize,
                        &numBytesEncrypted
                    )
                }
            }
        }

        guard cryptStatus == kCCSuccess else {
            return nil
        }

        let encryptedData = Data(bytes: buffer, count: numBytesEncrypted)
        return encryptedData
    }

    func aesDecrypt(key: Data, iv: Data) -> Data? {
        let bufferSize = count + kCCBlockSizeAES128
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        var numBytesDecrypted = 0

        let cryptStatus = key.withUnsafeBytes { keyBytes in
            iv.withUnsafeBytes { ivBytes in
                withUnsafeBytes { dataBytes in
                    CCCrypt(
                        CCOperation(kCCDecrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, key.count,
                        ivBytes.baseAddress,
                        dataBytes.baseAddress, count,
                        &buffer,
                        bufferSize,
                        &numBytesDecrypted
                    )
                }
            }
        }

        guard cryptStatus == kCCSuccess else {
            return nil
        }

        let decryptedData = Data(bytes: buffer, count: numBytesDecrypted)
        return decryptedData
    }
    
}
