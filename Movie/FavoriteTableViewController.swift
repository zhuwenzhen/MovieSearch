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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateFavoriteMovies(){
        // Function: Retrive array
        var title: String!
        var poster: String!
        var year: String!
        
        if UserDefaults.standard.object(forKey: "title") == nil {
            UserDefaults.standard.set(title, forKey: "title")
            UserDefaults.standard.set(poster, forKey: "poster")
            UserDefaults.standard.set(year, forKey:"year")
        } else{
            title = UserDefaults.standard.object(forKey: "title") as! String
            poster = UserDefaults.standard.object(forKey: "poster") as! String
            year = UserDefaults.standard.object(forKey: "year") as! String
            
            let movie_item = Movie(posterURL: poster, title: title, year: year)
            
            if favorite.contains(movie_item) {
                // do nothing
            } else {
                favorite.append(movie_item)
            }
        }
        print("fav: \(favorite)")
    }

    @IBAction func updateFavoriteView(_ sender: Any) {
        updateFavoriteMovies()
        self.tableView.reloadData()
        self.scrollToFirstRow()
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
        print("FAV!!!\(self.favorite)")
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

            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(favorite.isEmpty){
            print("return 1")
            return 1
        }
        else{
            return self.favorite.count
        }
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
