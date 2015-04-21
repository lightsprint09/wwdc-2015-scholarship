//
//  PersonaViewController.swift
//  LukasSchmidt
//
//  Created by Lukas Schmidt on 21.04.15.
//  Copyright (c) 2015 Lukas Schmidt. All rights reserved.
//

import UIKit
import MapKit

class PersonaViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }
    
    func setupMapView() {
        mapView.layer.cornerRadius = 8;
        let coordinate = CLLocationCoordinate2D(latitude: 49.353560, longitude: 9.139340)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1300, 2000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Mosbach 🇩🇪"
        
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("homeLocation")
        
        return annotationView;
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
