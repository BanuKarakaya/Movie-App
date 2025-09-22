//
//  Endpoint.swift
//  Movie App
//
//  Created by Banu Karakaya on 15.09.2025.
//

import Foundation

enum Endpoint {
    case movies(query: String)
    case populer(query: String)
    case searchMovies(searchText: String)
}

enum HttpMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    func request () -> URLRequest
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        "https://www.omdbapi.com/?"
    }
    
    var path: String {
        switch self {
        case .movies(let query):
            return "\(query)&s=jaws"
        case .populer(let query):
            return "\(query)&s=avatar"
        case .searchMovies(let searchText):
            return "apikey=f04b763&s=\(searchText)"
        }
    }
    
    var method: HttpMethod {
        .get
    }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: URL(string: baseUrl+path)!)
        request.httpMethod = method.rawValue
        return request
    }
}
