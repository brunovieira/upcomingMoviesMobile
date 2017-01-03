//
//  Image.swift
//  upcomingMoviesMobile
//
//  Created by Bruno on 03/01/17.
//  Copyright © 2017 Bruno. All rights reserved.
//

import Foundation
import UIKit

public class Image{
    
    static func getImageList(posterPath: String) -> UIImage! {
        let urlImage = "https://image.tmdb.org/t/p/w92/"
        let url = NSURL(string: urlImage+posterPath)
        let data = NSData(contentsOf:url! as URL)
        if data != nil {
            return UIImage(data:data! as Data)!
        }
        return UIImage(named: "tmdb")
        
    }
    
    static func getImageDetail(posterPath: String) -> UIImage! {
        let urlImage = "https://image.tmdb.org/t/p/w154/"
        let url = NSURL(string: urlImage+posterPath)
        let data = NSData(contentsOf:url! as URL)
        if data != nil {
            return UIImage(data:data! as Data)!
        }
        return UIImage(named: "tmdb")
    }
    
}
