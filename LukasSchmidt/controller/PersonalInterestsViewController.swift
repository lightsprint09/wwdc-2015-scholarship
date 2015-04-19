//
//  PersonalInterestsViewController.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 18.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class PersonalInterestsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    let text = ["sport": "", "ehealth": "In the summer of 2012 I started studying Medical Informatics at the university of Heidelberg. It is fun to learn so much new in a short period of time. I learned a lot about programming and felt confinement enough to lern Objective - C. I had to learn it on my own because we haven ´t any Macs at our campus.\n\nMaking software for medical use is hard because it could affect the life of other humans. We constantly think about how technology can improve medical systems and consumer healthcare. I like being part of this.", "code": "I care deeply in crafting creat software. But for me as an software engineer the look and feel of the software is just as important as reducing complexity, removing redundant code and getting better test coverage. "];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didSelectTrackField(sender: AnyObject) {
        displayText("sport")
    }
    
    @IBAction func didSelectCode(sender: AnyObject) {
        displayText("code")
    }
    
    @IBAction func didSelectMovies(sender: AnyObject) {
        displayText("movie")
    }
    
    @IBAction func didSelectEHealth(sender: AnyObject) {
        displayText("ehealth")
    }
    
    func displayText(key:String) {
        textView.text = text[key];
    }
    


}
