//
//  NowPlayingMoviewsViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/2/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class NowPlayingMoviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let urlWithAuth: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var movies: [Movie]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        
        // start animating activity indicator
        self.activityIndicator.startAnimating()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        // add target
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        moviesTableView.insertSubview(refreshControl, at: 0)
        
        Alamofire.request(urlWithAuth).responseJSON { (response) in
            let res = response.result.value! as! NSDictionary
            self.movies = Movie.movies(dictionaries: (res["results"] as? [NSDictionary])! as! [[String : Any]])
            
            self.moviesTableView.reloadData()
            
            // tell the activity indicator to stop
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = self.moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        movieCell.descriptionLabel.text = self.movies?[indexPath.row].description

        movieCell.titleLabel.text = self.movies?[indexPath.row].title
        
        movieCell.posterImageView.af_setImage(withURL: (self.movies?[indexPath.row].posterUrl)!)
        
        return movieCell
    }
    
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        Alamofire.request(urlWithAuth).responseJSON { (response) in
            let res = response.result.value! as! NSDictionary
            self.movies = Movie.movies(dictionaries: (res["results"] as? [NSDictionary])! as! [[String : Any]])
            
            self.moviesTableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let detailedViewController = segue.destination as! MovieDetailsViewController
        
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        
        let indexPath = self.moviesTableView.indexPath(for: cell)!
        
         detailedViewController.movie = self.movies![indexPath.row]
    }

}
