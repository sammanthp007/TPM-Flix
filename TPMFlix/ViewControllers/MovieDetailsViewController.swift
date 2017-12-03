//
//  MovieDetailsViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/2/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var movie: NSDictionary?
    
    // Hack for now to save trailer url
    var trailerURLString: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let movie = self.movie {
            self.titleLabel.text = movie["title"] as? String
            self.overviewLabel.text = movie["overview"] as? String
            self.releaseDate.text = movie["release_date"] as? String
            let backdrop_path = movie["backdrop_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backDropURL = URL (string: baseURLString + backdrop_path)!
            self.backDropImageView.af_setImage(withURL: backDropURL)
            
            if let posterPath = movie["poster_path"] as? String {
                let posterURL = URL(string: baseURLString + posterPath)!
                self.posterImageView.af_setImage(withURL: posterURL)
            }
            else {
                self.posterImageView = nil
            }
            
            // make a network call to get youtube key. bad location, but hack for now
            
            activityIndicator.startAnimating()

            let movieID = movie["id"]!
            
            let urlWithAuth: String = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"

            Alamofire.request(urlWithAuth).responseJSON { (response) in
                let res = response.result.value! as! NSDictionary
                if let allVideos = res["results"] as? [NSDictionary] {
                    let trailerKey = allVideos[0]["key"] as! String
                    
                    self.trailerURLString = "https://www.youtube.com/watch?v=\(trailerKey)"
                }
                
                self.activityIndicator.stopAnimating()
            }
        }
    }

    
    @IBAction func onPosterImageTap(_ sender: Any) {
        performSegue(withIdentifier: "toWebView", sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "toWebView" {
            print ("for to web")
            print (self.trailerURLString)
            
            let destinationVC = segue.destination as! MovieTrailerViewController
            destinationVC.movieTrailerURL = self.trailerURLString
        }
        // Pass the selected object to the new view controller.
    }


}
