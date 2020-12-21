//
//  CreatePinViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/21/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddressPinViewController: UIViewController {
    
    @IBOutlet weak var buttonFindOnMap: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressField: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.isEnabled = false
    }
    
    @IBAction func onFindMapClicked(_ sender: Any) {
        coordinates(forAddress: addressField.text!) {
            (location) in
            guard let location = location else {
                // Handle error here.
                return
            }
            self.openMapForPlace(lat: location.latitude, long: location.longitude)
        }
    }
    
    /**
     Transforming an address into a lat, long with the geocode.
     */
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
    /**
     Redirect map to the location found
     */
    func openMapForPlace(lat: Double, long: Double) -> Void {
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true) // Drop a pin at
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lat, long)
        myAnnotation.title = addressField.text
        mapView.addAnnotation(myAnnotation)
        buttonSubmit.isEnabled = true
    }
}
