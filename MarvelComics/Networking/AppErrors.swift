//
//  AppErrors.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 20/10/2022.
//

import Foundation

enum AppErrors: LocalizedError {
    
    case unknownError
    case invalidURL
    case errorDecoding
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "Unknown error"
        case .invalidURL:
            return "Invalid URL"
        case .errorDecoding:
            return "Decoding error"
        case .serverError(let error):
            return "Server error: \(error)"
        }
    }
}
