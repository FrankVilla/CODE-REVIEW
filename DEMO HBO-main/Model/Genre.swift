//
//  Genre.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import Foundation

struct Genre:Codable,Hashable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
struct AllGenres: Codable,Hashable {
    let genres: [Genre]
}
