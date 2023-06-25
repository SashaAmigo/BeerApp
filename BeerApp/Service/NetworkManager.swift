//
//  NetworkManager.swift
//  BeerApp
//
//  Created by Саша Amigo on 25.06.2023.
//

import Foundation
import Alamofire

enum Link {
    case randomURL
    
    var url: URL {
        switch self {
        case .randomURL:
            return URL(string: "https://api.punkapi.com/v2/beers")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init () { }
    private var imageLink = URL(string: "https://api.punkapi.com/v2/beers")!
    
    func fetchRecipes (from url: URL, completion: @escaping (Result<[Recipe], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    
                case .success(let value):
                    let recipes = Recipe.getRecipes(from: value)
                    completion(.success(recipes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
