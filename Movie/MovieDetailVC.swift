//
//  MovieDetailVC.swift
//  Movie
//
//  Created by Wenzhen Zhu on 3/8/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController {
    
    // Mark: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!

    var movie: Movie!
    var favorite = [Movie]()
    var delegate: favoritesUpdating?
    
    // Mark: - View
    override func viewDidLoad() {
        getMovieDetails(movie.imdbID)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        // user default: save data
        if let data = UserDefaults.standard.data(forKey: "movie"), let favoriteMovieList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Movie]{
            favorite.removeAll(keepingCapacity: false)
            for elem in favoriteMovieList{
                favorite.append(elem)
            }
            print("favorite list: \(favorite)")
        }
        else{
            print("Cannot retrieve from UserDefaults")
        }
        
        var exists = false
        for testMovie in favorite {
            if testMovie == movie {
                exists = true
            }
        }
        
        if !exists {
            favorite.append(movie)
        }
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorite)
        UserDefaults.standard.set(encodedData, forKey: "movie")
        
        delegate?.updatefavorites()
    }
    
    func showPoster(movie: Movie!)-> UIImage{
        let url = URL(string: movie.posterURL)
        if let data = try? Data(contentsOf: url!) {
            let image = UIImage(data: data)
            return image!
        }
        else{
            return UIImage(named: "blank_movie_poster.png")!
        }
    }
    
    func updateUI(_ movie: Movie!){
        titleLabel.text = movie.title + " (" + movie.year + ")";
        posterImageView.image = showPoster(movie: movie)
        ratingLabel.text = movie.rated
        runningTimeLabel.text = movie.runtime
        genreLabel.text = "Genre: " + movie.genre
        plotLabel.text = "Plot: \n" + movie.plot
        directorLabel.text = "Director: " + movie.director
        releasedLabel.text = movie.released
        imdbRatingLabel.text = "IMDB Rating: " + movie.imdbRating + "/10"
    }
    
    private func getJSON(path: String) -> JSON{
        guard let url = URL(string: path) else {return JSON.null}
        
        do{
            let data = try Data(contentsOf: url)
            return JSON(data: data)
        } catch {
            return JSON.null
        }
    }
    
    func getMovieDetails(_ imdbID: String){
        let path = "https://www.omdbapi.com/?i=\(imdbID)"
        let result = getJSON(path: path)
        
        let posterURL = result["Poster"].stringValue
        let country =  result["Country"].stringValue
        let plot = result["Plot"].stringValue
        let year = result["Year"].stringValue
        let title = result["Title"].stringValue
        let director = result["Director"].stringValue
        let runtime = result["Runtime"].stringValue
        let writer = result["Writer"].stringValue
        let genre = result["Genre"].stringValue
        let imdbID = result["imdbID"].stringValue
        let released = result["Released"].stringValue
        let imdbRating = result["imdbRating"].stringValue
        let awards = result["Awards"].stringValue
        let actors = result["Actors"].stringValue
        let rated = result["Rated"].stringValue
        
        let movie = Movie(posterURL: posterURL, country: country, plot: plot, year: year, title: title, director: director, runtime: runtime, writer: writer, genre: genre, imdbID: imdbID, released: released,  imdbRating: imdbRating, awards: awards, actors: actors, rated: rated)            
        self.updateUI(movie)
    }
}
