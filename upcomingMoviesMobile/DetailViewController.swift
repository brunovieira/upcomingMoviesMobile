//
//  DetailViewController.swift
//  upcomingMoviesMobile
//
//  Created by Bruno on 31/12/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

import UIKit

class DatailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var realese: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var poster: UIImageView!
    
    var movie : NSDictionary! = nil

    override func viewDidAppear(_ animated: Bool) {
        titleMovie.text = movie.object(forKey: "title") as! String?
        genres.text = movie.object(forKey: "genresValue") as! String?
        originalTitle.text = movie.object(forKey: "original_title") as! String?
        popularity.text = (movie.object(forKey: "popularity") as! NSNumber?)?.stringValue
        realese.text = movie.object(forKey: "release_date") as! String?
        average.text = (movie.object(forKey: "vote_average") as! NSNumber?)?.stringValue
        count.text = (movie.object(forKey: "vote_count") as! NSNumber?)?.stringValue
        
        overview.isEditable = false
        overview.text = movie.object(forKey: "overview") as! String?
        
        
        poster.image = Image.getImageDetail(posterPath: (movie.object(forKey: "poster_path")  as! String))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        edgeGestureRecognizer.edges = UIRectEdge.left
        edgeGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(edgeGestureRecognizer)
    }
    
    func handleTap(_ recognizer: UIPanGestureRecognizer) {
        performSegue(withIdentifier: "toListMovie", sender: self)
    }
}
