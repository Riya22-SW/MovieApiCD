//
//  MovieModel.swift
//  MoviesCD
//
//  Created by admin on 16/12/24.
//

import Foundation

struct MovieModel: Codable{
    let id:Int
    let movie : String
    let rating : Double
    let image : String
    let imdb_url : String
}

