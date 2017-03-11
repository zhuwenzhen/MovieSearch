//
//  MovieViewController.swift
//  Movie
//
//  Created by Wenzhen Zhu on 3/9/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import Foundation
import UIKit

protocol favoritesUpdating {
    func updatefavorites()
}

class MovieViewController: UITabBarController, favoritesUpdating {
    
    var favoritesViewController: FavoriteTableViewController?
    var searchViewController: SearchViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers = self.childViewControllers
        for navigationController in viewControllers {
            for viewController in navigationController.childViewControllers {
                if viewController.isKind(of: FavoriteTableViewController.self) {
                    favoritesViewController = viewController as? FavoriteTableViewController
                } else if viewController.isKind(of: SearchViewController.self) {
                    searchViewController = viewController as? SearchViewController
                }
            }
        }
        searchViewController?.delegate = self
    }
    
    func updatefavorites() {
        favoritesViewController?.updateFavoriteView(self)
    }
    
}
