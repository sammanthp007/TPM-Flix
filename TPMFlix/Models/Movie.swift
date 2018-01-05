//
//  Movie.swift
//  TPMFlix
//
//  Created by Samman Thapa on 1/6/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var description: String = ""
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        description = dictionary["overview"] as? String ?? "No description"
        
        let poster_base_url = "https://image.tmdb.org/t/p/w500"
        
        if let poster_path = dictionary["poster_path"] as! String? {
            posterUrl = URL(string: poster_base_url + poster_path)!
        }
        
        // Set the rest of the properties
    }
}
