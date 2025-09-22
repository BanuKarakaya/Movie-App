//
//  NetworkManager.swift
//  Movie App
//
//  Created by Banu Karakaya on 15.09.2025.
//

import Foundation

protocol NetworkManagerInterface {
    func request<T: Decodable> (_ endpoint: Endpoint, completion: @escaping (Swift.Result  <T, Error>) -> Void) -> Void
    
    func getMovies(completion: @escaping (Swift.Result<Response , Error>) -> Void) -> Void
    
    func getPopuler(completion: @escaping (Swift.Result<Response , Error>) -> Void) -> Void
    
    func getSearchMovies(completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void
}


final class NetworkManager: NetworkManagerInterface {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T:Decodable> (_ endpoint : Endpoint, completion : @escaping (Swift.Result  <T, Error>) ->Void) ->Void {
        
        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.request()) {(data ,response , error) in
            if let error = error {
                print(error)
            }
            if let response = response as? HTTPURLResponse {}
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonData))
                    
                }catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSessionTask.resume()
    }
    
    func getMovies(completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.movies(query: "apikey=f04b763")
        request(endpoint, completion: completion)
    }
    
    func getPopuler(completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.populer(query: "apikey=f04b763")
        request(endpoint, completion: completion)
    }
    
    func getSearchMovies (completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void {
        let endpoint = Endpoint.searchMovies(searchText: searchText)
        request(endpoint, completion: completion)
    }
}


