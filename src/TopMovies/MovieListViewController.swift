//
//  MovieListViewController.swift
//  TopMovies
//
//  Created by Sean Narvasa on 1/11/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies: [NSDictionary]? // this is an array of NSDictionary aka. a Hash
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0     // ?? says "if count is nil, default to zero
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) // use the non-optional version
        if let moviecell = cell as? MovieTableViewCell {
            moviecell.posterImageview.image = nil
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        
        self.title = "🔝🎞"
        
        let itunesURL = NSURL(string: "https://itunes.apple.com/us/rss/topmovies/limit=100/json")!
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: itunesURL)) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let moviesArray = json.valueForKeyPath("feed.entry") as? [NSDictionary]
                self.movies = moviesArray
                
                self.movieListTableView.reloadData()    // this tells the tableview to reload
                
                print("Yay! The Movies Downloaded! 🎉")
            }
            }.resume()
    }


    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
        let moviecell = cell as! MovieTableViewCell
        
        let title = self.titleStringForMovieAtIndex(indexPath.row)
        let director = self.directorStringForMovieAtIndex(indexPath.row)
        let summary = self.summaryStringForMovieAtIndex(indexPath.row)
        
        moviecell.movieLabel?.text = title
        moviecell.directorLabel?.text = director
        moviecell.descriptionLabel?.text = summary
        
        let posterImageURL = self.posterImageURLForMovieAtIndex(indexPath.row)
        //self.posterImageView?.image = nil
        moviecell.posterImageview?.setImageWithURL(posterImageURL)
        
        moviecell.movieLabel.text = "\(indexPath.row)"
    }

    func titleStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let title = movie?.valueForKeyPath("im:name.label") as? String
        return title
    }

    func directorStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let director = movie?.valueForKeyPath("im:artist.label") as? String
        return director
    }

func summaryStringForMovieAtIndex(index: Int) -> String? {
    let movie = self.movies?[index]
    let summary = movie?.valueForKeyPath("summary.label") as? String
    return summary
}

func posterImageURLForMovieAtIndex(index: Int) -> NSURL {
    let movie = self.movies?[index]
    let posterImageURLArray = movie?.valueForKeyPath("im:image.label") as? [String]
    let posterImageURLString = posterImageURLArray?.last
    let posterImageURL = NSURL(string: posterImageURLString!)!
    return posterImageURL
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
