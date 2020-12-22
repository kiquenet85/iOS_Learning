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
    @IBOutlet weak var linkField: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.isEnabled = false
    }
    
    @IBAction func onFindMapClicked(_ sender: Any) {
        if (!addressField.text!.isEmpty){
            coordinates(forAddress: addressField.text!) {
                (location) in
                guard let location = location else {
                    // Handle error here.
                    return
                }
                self.openMapForPlace(lat: location.latitude, long: location.longitude)
            }
        } else {
            noAddressFound()
        }
    }
    
    fileprivate func managePostOrUpdateLocation(_ success: Bool, _ error: Error?) {
        if success {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.sorryLocationNotCreated()
            self.buttonSubmit.isEnabled = false
        }
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        UdacityClient.getUserLocation(){
            (location, error) in
            
            let lat = self.mapView.annotations[0].coordinate.latitude
            let long = self.mapView.annotations[0].coordinate.longitude
            let newLocation = UserLocation(firstName: "Nestor", lastName: "DLP", longitude: long, latitude: lat, mapString: self.addressField.text!, mediaURL: self.linkField.text ?? "", uniqueKey: "", objectId: nil)
            
            if (location == nil){
                UdacityClient.postUserLocation(newUserLocation: newLocation){
                    (success, error) in
                    self.managePostOrUpdateLocation(success, error)
                }
            } else {
                UdacityClient.updateUserLocation(newUserLocation: newLocation){
                    (success, error) in
                    self.managePostOrUpdateLocation(success, error)
                }
            }
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
        if (!mapView.annotations.isEmpty){
            mapView.removeAnnotation(mapView.annotations[0])
        }
        mapView.addAnnotation(myAnnotation)
        buttonSubmit.isEnabled = true
    }
    
    fileprivate func noAddressFound() {
        let alertcontroller = UIAlertController()
        alertcontroller.title = "No address Found"
        alertcontroller.message = "Your input is empty or was not found"
        
        showAlert(alertcontroller)
    }
    
    fileprivate func sorryLocationNotCreated() {
        let alertcontroller = UIAlertController()
        alertcontroller.title = "Error"
        alertcontroller.message = "Sorry there was an error, try later"
        
        showAlert(alertcontroller)
    }
    
    
    fileprivate func showAlert(_ alertcontroller: UIAlertController) {
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertcontroller.addAction(okAction)
        present(alertcontroller, animated: true, completion: nil)
    }
}
