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
    let text = ["sport": "At the age of 8 I started to do athletics. It helped me to push the limits of my body and to learn how to control every part of my body. In the past 2 years I started doing a lot of pole vaulting.\nWhen doing sport I forget all about objects and databases. After an hour of sports my mind is open for new ideas and thoughts.", "ehealth": "In the summer of 2012 I started studying Medical Informatics at the university of Heidelberg. It is fun to learn so much new in a short period of time. I learned a lot about programming and felt confinement enough to lern Objective - C. I had to learn it on my own because we haven ´t any Macs at our campus.\n\nMaking software for medical use is hard because it could affect the life of humans. We constantly think about how technology can improve medical systems and consumer healthcare. I like being part of this.", "code": "I care deeply in crafting great software. But for me as a software engineer the look and feel of the software is just as important as reducing complexity, removing redundant code and getting better test coverage. Developing software is a lot of fun because you can do all thinks you can imagine.", "movie": "I visit the cinema a lot to enjoy great movies with friends. Anoyed by the bad software solution our local cinema uses, me and my friends tried to build up an own solution. It is hard but at the end we want to get a solution which is fun to use for customers and cinema employees."];

    override func viewDidLoad() {
        super.viewDidLoad()
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
