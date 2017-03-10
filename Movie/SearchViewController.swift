//
//  ViewController.swift
//  MovieSearch
//
//  Created by Wenzhen Zhu on 3/7/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, favoritesUpdating {
    // MARK: - Properties
    var movies: [Movie] = []
    var thePosterCache: [UIImage] = []
    
     @IBOutlet weak var searchBar: UISearchBar!
     @IBOutlet weak var tableView: UITableView!
    
    var delegate: favoritesUpdating?

    // MARK: - View Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatefavorites() {
        delegate?.updatefavorites()
    }
    
    private func cacheImages() {
        for item in movies {
            let url = URL(string: item.posterURL)
            if let data = try? Data(contentsOf: url!) {
                let image = UIImage(data: data)
                thePosterCache.append(image!)
            }
        }
    }
    
    private func searchForMovie(title: String)-> JSON {
        let escapedPath = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let path = "https://www.omdbapi.com/?s=\(escapedPath!)"
        let json = getJSON(path: path)
        return json
    }
    
    // MARK: - TABLE VIEW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "showMovieDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let destinationVC = segue.destination as? MovieDetailVC {
                destinationVC.delegate = self
                if let movie = sender as? Movie {
                    destinationVC.movie = movie
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        cell.configureCell(self.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        let searchText = searchBar.text!
        // get JSON string from response
        let json = searchForMovie(title: searchText)
        movies.removeAll()
        for result in json["Search"].arrayValue {
            let title = result["Title"].stringValue
            let posterURL = result["Poster"].stringValue
            let imdbID = result["imdbID"].stringValue
            let year = result["Year"].stringValue
            
            movies.append(Movie(posterURL: posterURL, country: "", plot: "", year: year, title: title, director: "", runtime: "", writer: "", genre: "", imdbID: imdbID, released: "",  imdbRating: "", awards: "", actors: "", rated: ""))
        }
        self.tableView.reloadData()
        self.scrollToFirstRow()
    }
}
