//
//  ApiKeys.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import Foundation
import CryptoKit

struct ApiKeys {
    
    let publicKey = "8aab980f88caaca37c018f1abf726f84"
    let privateKey = "d8c8c92b97f3cad75d52f1145312782c4b3f89de"
    let ts = String(Date().timeIntervalSince1970)
    
    private func MD5(stringOfWords: String) -> String {
        let digest = Insecure.MD5.hash(data: stringOfWords.data(using: .utf8) ?? Data())
        let result = digest.map { String(format: "%02hhx", $0) }.joined()
        return result
    }
    
    func hash() -> String {
        return MD5(stringOfWords: "\(ts)\(privateKey)\(publicKey)")
    }
}
