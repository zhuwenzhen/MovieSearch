//
//  FavoriteTableViewController.swift
//  Movie
//
//  Created by Wenzhen Zhu on 3/8/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // Mark: - Properties
    var favorite: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!

    // Mark: - Set up view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self;
        updateFavoriteView(self)
    }
    
    func updateFavoriteMovies(){
        // retrieving a value for a key
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

    }

    func updateFavoriteView(_ sender: Any) {
        updateFavoriteMovies()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if favorite.isEmpty{
            return cell
        }
        else{
            cell.configureCell(self.favorite[indexPath.row])
            return cell
        }
    }
    
    // delete from favorite
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            print(indexPath.row)
            if favorite.isEmpty {
                
            } else{
                favorite.remove(at: indexPath.row)
                tableView.reloadData()
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorite)
                UserDefaults.standard.set(encodedData, forKey: "movie")

            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(favorite.isEmpty){
            print("favorite movie collection is empty")
            return 0
        }
        else{
            return self.favorite.count
        }
    }

}
