//
//  MovieCell.swift
//  Movie
//
//  Created by Wenzhen Zhu on 3/8/17.
//  Copyright © 2017 Wenzhen Zhu. All rights reserved.
//

import Foundation

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Disable cell highlight when selected
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(_ movie: Movie) {
        let url = URL(string: movie.posterURL)
        if let data = try? Data(contentsOf: url!) {
            let image = UIImage(data: data)
            posterImageView?.image = image
        }else{
            posterImageView?.image = UIImage(named: "blank_movie_poster.png")
        }
        
        titleLabel.text = movie.title
        yearLabel.text = movie.year
    }
}
