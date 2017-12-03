//
//  MovieTrailerViewController.swift
//  TPMFlix
//
//  Created by Samman Thapa on 12/3/17.
//  Copyright © 2017 Samman Thapa. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    
    @IBOutlet weak var videoWebKitView: WKWebView!
    
    var movieTrailerURL: String = "https://www.youtube.com/watch?v=G7plXOc_L_0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let requestURL = URL(string: movieTrailerURL)!
        
        let request = URLRequest(url: requestURL)
        
        videoWebKitView.load(request)
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
