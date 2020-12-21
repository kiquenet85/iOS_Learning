//
//  MapLocationsViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/20/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locations : [UserLocation] = []
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UdacityClient.getLocations(){
            (userLocations, error) in
            
            if error == nil {
                self.locations = userLocations!
                self.fillMapWithData()
            } else {
                self.locations = []
            }
        }
        
        self.mapView.delegate = self;
    }
    
    func fillMapWithData(){
        shareDataWithTabControllerListTab()
        for userLocation in self.locations {
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(userLocation.latitude)
            let long = CLLocationDegrees(userLocation.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = userLocation.firstName
            let last = userLocation.lastName
            let mediaURL = userLocation.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            self.annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
    
    func shareDataWithTabControllerListTab(){
        let listTabController = self.tabBarController!.viewControllers![1] as! MapListLocationsViewController
        listTabController.locations = self.locations
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                print(toOpen)
                if #available(iOS 10.0, *) {
                    app.open(URL(string: "\(toOpen)")!, options: [:], completionHandler: nil)
                } else {
                    app.openURL(URL(string: "\(toOpen)")!)
                }
            }
        }
    }
    
    //called when select an annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //Called when deselects the annotation
    private func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        view.removeGestureRecognizer(view.gestureRecognizers!.first!)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        if let view = sender.view as? MKAnnotationView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                print(toOpen)
                if #available(iOS 10.0, *) {
                    app.open(URL(string: "\(toOpen)")!, options: [:], completionHandler: nil)
                } else {
                    app.openURL(URL(string: "\(toOpen)")!)
                }
            }
        }
    }
}
