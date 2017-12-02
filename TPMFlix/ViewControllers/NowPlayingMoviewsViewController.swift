//
//  NowPlayingMoviewsViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/2/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit

import Alamofire

class NowPlayingMoviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var moviesTableView: UITableView!
    
    let urlWithAuth: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    var movies: [NSDictionary]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        
        Alamofire.request(urlWithAuth).responseJSON { (response) in
            let res = response.result.value! as! NSDictionary
            self.movies = res["results"] as? [NSDictionary]
            
            print (self.movies)
            
            self.moviesTableView.reloadData()
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
        
        movieCell.descriptionLabel.text = self.movies?[indexPath.row]["overview"] as? String

        movieCell.titleLabel.text = self.movies?[indexPath.row]["original_title"] as? String
        
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
