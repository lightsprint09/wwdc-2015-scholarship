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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        return cell
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func login() {
        
        //loginService.loginWithUsername("lightsprint09", andPassword: "1234", withCompletionHandler: didLogin)
    }
    
    func didLogin(success:Bool, error:NSError) {
        if success == true {
            moviePlaytimeSerice.loadMoviePlaytimeListFromCinemaWithID(1, withBlock: nil)
        }
    }
    
    func didLoadMovies(movies:Array<Dictionary<String, AnyObject>>, error:NSError) {
        println(movies)
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
