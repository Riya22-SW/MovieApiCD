//
//  MoviesModel.swift
//  MoviesCD
//
//  Created by admin on 16/12/24.
//

import Foundation

struct MoviesModel: Codable{
    let id : Int
    let title: String
    let year: Int
    let genre: [String]
    let rating: Double
    let director: String
    let actors: [String]
    let plot: String
    let poster: String
    let trailer: String
    let runtime: Int
    let awards: String
    let country: String
    let language: String
    let boxOffice: String
    let production: String
    let website: String
    
}

