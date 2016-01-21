//
//  MovieTableViewCell.swift
//  TopMovies
//
//  Created by Sean Narvasa on 1/11/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageview: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
