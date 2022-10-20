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
    
    func fetchComics(completion: @escaping(Result<ApiResult, Error>) -> Void) {
        let apiKeys = ApiKeys()
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
        
        request(route: .fetchComics, method: .get, parameters: parameters, completion: completion)
    }
    
    
    
    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameters: [String:Any]? = nil,
                                     completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: .get, parameters: parameters) else {
            completion(.failure(AppErrors.unknownError))
            return
        }
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
//                let jsonResponse = try? JSONSerialization.jsonObject(with: data)
//                print(jsonResponse ?? "Wystąpił error podczas JSONSerialization")
            } else if let error = error {
                result = .failure(error)
                print("Wystąpił error podczas URLSession")
            }
            
            DispatchQueue.main.async {
                self.handleResposne(result: result, completion: completion)
            }
        }.resume()
    }
    
    
    
    private func handleResposne<T: Codable>(result: Result<Data, Error>?,
                                           completion: (Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(AppErrors.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            guard let response = try? JSONDecoder().decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppErrors.errorDecoding))
                return
            }
            guard let data = response.data else {
                completion(.failure(AppErrors.unknownError))
                return
            }
            
            completion(.success(data))
            
        case .failure(let error):
            completion(.failure(error))
        }
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
