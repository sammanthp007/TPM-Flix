//
//  MovieCollectionViewCell.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/3/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            self.posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
}
