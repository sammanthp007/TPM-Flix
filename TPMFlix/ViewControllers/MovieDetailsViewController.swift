//
//  MovieDetailsViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/2/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = self.movie {
            self.titleLabel.text = movie["title"] as? String
            self.overviewLabel.text = movie["overview"] as? String
            self.releaseDate.text = movie["release_date"] as? String
            let backdrop_path = movie["backdrop_path"] as! String
            let posterPath = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backDropURL = URL (string: baseURLString + backdrop_path)!
            self.backDropImageView.af_setImage(withURL: backDropURL)
            
            let posterURL = URL(string: baseURLString + posterPath)!
            self.posterImageView.af_setImage(withURL: posterURL)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
