//
//  SupereroMoviesViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/3/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SupereroMoviesViewController: UIViewController, UICollectionViewDataSource {


    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let urlWithAuth: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

    var movies: [NSDictionary]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.moviesCollectionView.dataSource = self
        
        // start animating activity indicator
        self.activityIndicator.startAnimating()
        
        Alamofire.request(urlWithAuth).responseJSON { (response) in
            let res = response.result.value! as! NSDictionary
            self.movies = res["results"] as? [NSDictionary]
            
            self.moviesCollectionView.reloadData()
            
            // tell the activity indicator to stop
            self.activityIndicator.stopAnimating()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        
        let poster_base_url = "https://image.tmdb.org/t/p/w500"
        
        if let poster_path = self.movies?[indexPath.row]["poster_path"] as! String? {
            let poster_url = URL(string: poster_base_url + poster_path)!
            movieCell.posterImageView.af_setImage(withURL: poster_url)
        }
        
        return movieCell
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
