//
//  ViewController.swift
//  upcomingMoviesMobile
//
//  Created by Bruno on 28/12/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var filter: UITextField!
    @IBOutlet weak var lista: UITableView!
    
    var listMoviesOriginal: [NSDictionary]! = nil
    var listMovies: [NSDictionary]! = nil
    var listGenres: [NSDictionary]! = nil
    var load : UIActivityIndicatorView!
    
    var movieSelected : NSDictionary! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load = Loading(view: self.view)
        loadListMovies();
        loadListGenres();
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailMovie" {
            let nextStep = segue.destination as! DatailViewController
            nextStep.movie = movieSelected
        }
    }
    
    @IBAction func filterAction(_ sender: Any) {
        let filter : String = self.filter.text!
        if(filter == "") {
            self.listMovies = self.listMoviesOriginal
        } else {
            let moviesListFiltered = self.listMoviesOriginal.filter{
                let title : NSString = ($0["title"]! as AnyObject).lowercased as NSString
                return title.contains(filter.lowercased())
            }
            self.listMovies = moviesListFiltered
        }
        self.lista.reloadData()
    }
    
    func loadListMovies() {
        load.startAnimating()
        let session = URLSession.init(configuration:URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
        
        let urlMoviesObj = MoviesStore.moviesURL
        
        let task = session.dataTask(with: urlMoviesObj as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                AlertMessage.showAlert(title: "Error", message: (error?.localizedDescription)!, view: self)
                self.load.stopAnimating()
            }
            else{
                let jsonResult:NSDictionary = ( try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                self.listMoviesOriginal = jsonResult.value(forKey: "results") as! [NSDictionary]
                self.listMovies = self.listMoviesOriginal
                self.load.stopAnimating()
                
                self.lista.reloadData()
            }
        })
        task.resume()
        
    }
    
    func loadListGenres() {
        load.startAnimating()
        let session = URLSession.init(configuration:URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
        
        let urlGenreObj = GenreStore.genresURL
        
        let task = session.dataTask(with: urlGenreObj as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                AlertMessage.showAlert(title: "Error", message: (error?.localizedDescription)!, view: self)
                self.load.stopAnimating()
            }
            else{
                let jsonResult:NSDictionary = ( try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                self.listGenres = jsonResult.value(forKey: "genres") as! [NSDictionary]
                self.load.stopAnimating()
                
                self.lista.reloadData()
            }
        })
        task.resume()
        
    }
    
    func getGenres(indexMovie: Int) -> String {
        let genreIds: NSArray = (listMovies[indexMovie].object(forKey: "genre_ids")  as! NSArray)
        var genreName : String = ""
        if(listGenres != nil && listGenres.count != 0) {
            for item in genreIds {
                let id : NSNumber = item as! NSNumber
                let genreObj = listGenres.filter{($0["id"] as! NSNumber) == id}.first
                genreName += genreObj?.object(forKey: "name") as! String + " "
            }
        }
        return genreName
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myList = listMovies {
            return myList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovieItem")! as! CellMovieItem
        tableView.backgroundColor = TableConfig.tableBackgroundColor
        tableView.layer.cornerRadius = TableConfig.tableCornerRadius
        cell.backgroundColor = TableConfig.cellBackgroundColor
        cell.layer.borderWidth = TableConfig.cellBorderWidth
        cell.layer.borderColor = TableConfig.cellBorderColor
        cell.layer.cornerRadius = TableConfig.cellCornerRadius
        
        cell.selectedBackgroundView = UIView()

        cell.titleMovie.text = (listMovies[indexPath.row].object(forKey: "title")  as! String)
        cell.releaseMovie.text = (listMovies[indexPath.row].object(forKey: "release_date")  as! String)
        
        cell.posterMovie.image = Image.getImageList(posterPath: (listMovies[indexPath.row].object(forKey: "poster_path")  as! String))
        
        let genresValue = getGenres(indexMovie: indexPath.row)
        cell.genereMovie.text = genresValue
        listMovies[indexPath.row].setValue(genresValue, forKey: "genresValue")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = listMovies[indexPath.row]
        performSegue(withIdentifier: "toDetailMovie", sender: movieSelected)
    }
}

