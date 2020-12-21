//
//  MapListLocationsViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 12/21/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class MapListLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var locations : [UserLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Location Favorite List";
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
        
        // Fetches the appropriate app for the data source layout.
        let appItem = locations[indexPath.row]
        
        cell.textLabel?.text = "\(appItem.firstName) \(appItem.lastName)"
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: false)
        
        if tableView.cellForRow(at: indexPath) != nil {
            
            let location = self.locations[indexPath.row]
            print(location.mediaURL)
            let app = UIApplication.shared
            if #available(iOS 10.0, *) {
                app.open(URL(string: "\(location.mediaURL)")!, options: [:], completionHandler: nil)
            } else {
                app.openURL(URL(string: "\(location.mediaURL)")!)
            }
        }
    }
    
}
