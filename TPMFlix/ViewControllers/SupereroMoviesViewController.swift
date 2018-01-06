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
    
    var movies: [Movie]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.moviesCollectionView.dataSource = self
        
        // start animating activity indicator
        self.activityIndicator.startAnimating()
        
        let layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemPerRow: CGFloat = 4
        let interItemSpacing: CGFloat = 1
        
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        
        let widthOfRow = self.moviesCollectionView.frame.size.width
        let totalSpacing = interItemSpacing * (itemPerRow - 1)
        let widthOfItem = (widthOfRow - totalSpacing) / itemPerRow

        layout.itemSize = CGSize(width: widthOfItem, height: widthOfItem * 1.5)
        
        MovieApiManager().getNowPlayingMovies { (returned_movies: [Movie]?, error: Error?) in
            if let movies = returned_movies {
                self.movies = movies
                self.moviesCollectionView.reloadData()
            }
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
        
        movieCell.movie = self.movies?[indexPath.row]
        
        return movieCell
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
        let item = sender as! UICollectionViewCell
        
        let indexPath = self.moviesCollectionView.indexPath(for: item)!
        
        detailedViewController.movie = self.movies![indexPath.row]
    }

}
