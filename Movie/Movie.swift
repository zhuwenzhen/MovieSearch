//
//  Movie.swift
//  Movie
//
//  Created by Wenzhen Zhu on 3/7/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import Foundation

class Movie: Equatable {
    
    var posterURL: String!
    var country: String!
    var plot: String!
    var year: String!
    var title: String!
    var director: String!
    var runtime: String!
    var writer: String!
    var genre: String!
    var imdbID: String!
    var released: String!
    var imdbRating: String!
    var awards: String!
    var actors: String!
    var rated: String!
    
    // small movie
    init(posterURL: String, title: String, year: String){
        self.posterURL = posterURL
        self.title = title
        self.year = year
    }
    
    // detailed movie
    init(posterURL: String, country: String, plot: String, year: String, title: String, director:String, runtime:String, writer:String, genre:String, imdbID: String, released:String,  imdbRating:String, awards:String, actors:String, rated:String){
        self.posterURL = posterURL
        self.country = country
        self.plot = plot
        self.year = year
        self.title = title
        self.director = director
        self.runtime = runtime
        self.writer = writer
        self.genre = genre
        self.imdbID = imdbID
        self.released = released
        self.imdbRating = imdbRating
        self.awards = awards
        self.actors = actors
        self.rated = rated
    }
    
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.posterURL == rhs.posterURL && lhs.title == rhs.title && lhs.year == rhs.year
    }
    
    
    
}

