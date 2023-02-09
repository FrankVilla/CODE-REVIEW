//
//  PersistenceManager.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//


import Foundation

enum PersistenceActionType {
    case add,remove
}
enum Gender {
    case genderTypes
}

class PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
        static let genders   = "genders"
    }
    
    static func updateWith(favorite: Movie, actionType: PersistenceActionType, completed: @escaping ((MovError)?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyExists)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.title == favorite.title  }
                }
                completed(saveToFavorites(favorites: retrievedFavorites))
                return
            case .failure(let error):
                completed(error)
                return
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Movie],MovError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.failure(.unableToComplete))
            return
        }
        do {
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([Movie].self,from: favoritesData)
            completed(.success(decodedFavorites))
        } catch {
            completed(.failure(.unableToParse))
        }
    }
    
    static func saveToFavorites(favorites: [Movie]) ->MovError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func getGenders(in genreArray: [Int]) -> String {
        var genreString = ""
        
        let dict = findGenres()
        
        if let dict = dict {
            for genre in genreArray {
                if let type = dict[genre] {
                    genreString += "\(String(type)),"
                }
            }
        }
        else {
            return "No Genre"
        }
        
        genreString.remove(at: genreString.index(before: genreString.endIndex))
        
        return genreString
    }
    
    static func findGenres() -> [Int:String]? {
        let dict:[Int:String]?
        
        if let genderJson = defaults.object(forKey: Keys.genders) as? Data {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let GenderJson = try decoder.decode(AllGenres.self, from: genderJson)
                let genres = GenderJson.genres
                let myDictionary = genres.reduce([Int: String]()) { (dict, gender) -> [Int: String] in
                    var dict = dict
                    dict[gender.id] = gender.name
                    return dict
                }
                dict = myDictionary
                return dict
    
                
            } catch {
                print(error.localizedDescription)
            }
        }
        else {
                let url = Bundle.main.url(forResource: "genders", withExtension: "json")!
                let data = try! Data(contentsOf: url)
                defaults.set(data, forKey: Keys.genders)
            }
        
        return findGenres()
        
    }
    static func deleteGenders() {
        defaults.removeObject(forKey: Keys.genders)
    }
}
