//
//  Constants.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation

struct Constants {
    static let apiKey = "?api_key=cfda7ff25007f36b79231480d8c00104"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct Endpoints {
        static let urlTokenNew = "3/authentication/token/new"
        static let urValidateWithLogin = "3/authentication/token/validate_with_login"
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
