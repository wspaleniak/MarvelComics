//
//  DecodingStructure.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 20/10/2022.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let attributionHTML: String?
    let attributionText: String?
    let code: Int?
    let copyright: String?
    let etag: String?
    let status: String?
    let data: T? // ApiResult
}

struct ApiResult: Codable {
    let count: Int?
    let limit: Int?
    let offset: Int?
    let total: Int?
    let results: [Comic]?
}

struct Comic: Codable {
    let title: String?
    let creators: Creator
    let description: String?
    let thumbnail: Thumbnail?
}

struct Creator: Codable {
    let items: [Items]?
}

struct Items: Codable {
    let name: String
    let role: String
    
    var writer: String? {
        if role.contains("writer") { return "\(role): \(name)" }
        else { return nil }
    }
    
    var author: String { return "\(role): \(name)" }
}

struct Thumbnail: Codable {
    let path: String?
    
    var urlString: String {
        guard var path = path else { return "" }
        
        if path.contains("image_not_available") {
            return "https://parade.com/.image/t_share/MTkwNTgxMjkxNjk3NDQ4ODI4/marveldisney.jpg"
        }
        let index = path.index(path.startIndex, offsetBy: 4)
        path.insert("s", at: index)
        path.append(".jpg")
        return path
    }
}
