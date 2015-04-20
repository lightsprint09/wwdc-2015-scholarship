//
//  CinemaManagerViewController.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 16.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class CinemaManagerViewController: UIViewController, UICollectionViewDataSource {
    let loginService:LSLoginService = LSLoginServiceImpl()
    let moviePlaytimeSerice: LSMoviePlaytimeDownloader = LSMoviePlaytimeDownloaderImpl()
    let coverImageLoader: LSCoverImageLoader = LSCoverImageLoaderImpl()
    var movies:NSArray?
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = self.movies {
            return movies.count;
        }
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as! UICollectionViewCell
        if let movieCell = cell as? MovieCollectionViewCell {
            let movie = movies!.objectAtIndex(indexPath.item) as! NSDictionary
            movieCell.setMovie(movie)
            loadCover(movieCell, movie: movie)
        }
        
        return cell
    }
    
    func loadCover(cell:MovieCollectionViewCell, movie:NSDictionary) {
        let url = NSURL(string: IMAGE_URL + (movie.valueForKey("coverimageurl") as! String))
        println(url)
        coverImageLoader.downloadMovieCoverImageWithURL(url, didFinishLodingImage: {imageData, error in
            dispatch_async(dispatch_get_main_queue()) {
                cell.setImageData(imageData)
            }
        })
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func login() {
        loginService.loginWithUsername("lightsprint09", andPassword: "1234", withCompletionHandler: didLogin)
    }
    
    func didLogin(success:Bool, error:NSError!) {
        if success == true {
            moviePlaytimeSerice.loadMoviePlaytimeListFromCinemaWithID(1, withBlock: {movies, error in
                dispatch_async(dispatch_get_main_queue()) {
                    self.didLoadMovies(movies, error: error)
                }
            })
        }
    }
    
    func didLoadMovies(movies:NSArray!, error:NSError!) {
        self.movies = movies
        movieCollectionView.reloadData()
    }
}
