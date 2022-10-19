//
//  Route.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://gateway.marvel.com"
    
    case fetchComics
    
    var description: String {
        switch self {
        case .fetchComics: return "/v1/public/comics"
        }
    }
}
