//
//  NetworkService.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() { }
    
    let apiKeys = ApiKeys()
    
    func fetchComics() -> URLRequest {
        let parameters = [
            "format":"comic",
            "formatType":"comic",
            "noVariants":"true",
            "limit":"25",
            "offset":"0",
            "orderBy":"-onsaleDate",
            "ts":"\(apiKeys.ts)",
            "apikey":"\(apiKeys.publicKey)",
            "hash":"\(apiKeys.hash())"
        ]
        
        return createRequest(route: .fetchComics, method: .get, parameters: parameters)!
    }
    
    
    
    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameters: [String:Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        
        //?
    }
    
    
    
    private func handleRequest<T: Codable>(result: Result<Data, Error>?,
                                           completion: (Result<T, Error>) -> Void) {
        
        //?
    }
    
    
    
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String:Any]? = nil) -> URLRequest? {
        
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            switch method {
            case .get:
                var urlComponents = URLComponents(string: urlString)
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponents?.url
            case .post, .delete, .patch:
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
        }
        return urlRequest
    }
}
