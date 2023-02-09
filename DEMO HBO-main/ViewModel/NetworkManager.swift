//
//  NetworkManager.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    func getMovies(category: MovieFilter,completed: @escaping (Result<[Movie],MovError>) -> Void) {
        let url = NetworkConstants.baseUrl.rawValue + category.rawValue + "?api_key=\(NetworkConstants.apiKey.rawValue)" + "&language=en-US&page=1"
        guard let requestUrl = URL(string: url) else {
            completed(.failure(.invalidRequest))
            return
        }
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
            
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let MovieJson = try decoder.decode(Results.self, from: data)
                let movies = MovieJson.results
                completed(.success(movies))
            } catch {
                completed(.failure(.unableToParse))
            }
            
        }.resume()
        
    }
    func getMovieImage(posterPath: String,completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: posterPath)
        if let image = cache.object(forKey: cacheKey) {

            completed(image)
            return
        }
        let url = NetworkConstants.imageUrl.rawValue + posterPath
          guard let requestUrl = URL(string: url) else {
              completed(nil)
              return
          }
          URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
              guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                  completed(nil)
                  return
              }
              if let _ = error {
                  completed(nil)
                  return
              }
              guard let data = data else {
                  completed(nil)
                  return
              }
            guard let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
            return
              
          }.resume()
       }
}
