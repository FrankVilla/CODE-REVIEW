//
//  Constants.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 25/02/2022.
//

import UIKit

enum MovieFilter: String {
    case latest     = "latest"
    case top        = "top_rated"
    case popular    = "popular"
    case upcoming   = "upcoming"
}

enum NetworkConstants: String {
    case apiKey   = "640f6d8d0be3a9a0af9154cf4e1c94c8"
    case baseUrl  = "https://api.themoviedb.org/3/movie/"
    case imageUrl = "https://image.tmdb.org/t/p/w500"
}

enum MovieCategory: String {
    case top        = "Top Rated"
    case popular    = "Popular"
    case upcoming   = "Upcoming"
}

enum GenderJson: String {
    case json      = """
    {
      "genres": [
        {
          "id": 28,
          "name": "Action"
        },
        {
          "id": 12,
          "name": "Adventure"
        },
        {
          "id": 16,
          "name": "Animation"
        },
        {
          "id": 35,
          "name": "Comedy"
        },
        {
          "id": 80,
          "name": "Crime"
        },
        {
          "id": 99,
          "name": "Documentary"
        },
        {
          "id": 18,
          "name": "Drama"
        },
        {
          "id": 10751,
          "name": "Family"
        },
        {
          "id": 14,
          "name": "Fantasy"
        },
        {
          "id": 36,
          "name": "History"
        },
        {
          "id": 27,
          "name": "Horror"
        },
        {
          "id": 10402,
          "name": "Music"
        },
        {
          "id": 9648,
          "name": "Mystery"
        },
        {
          "id": 10749,
          "name": "Romance"
        },
        {
          "id": 878,
          "name": "Science Fiction"
        },
        {
          "id": 10770,
          "name": "TV Movie"
        },
        {
          "id": 53,
          "name": "Thriller"
        },
        {
          "id": 10752,
          "name": "War"
        },
        {
          "id": 37,
          "name": "Western"
        }
      ]
    }
    """
}
