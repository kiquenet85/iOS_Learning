//
//  ListAppTableViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 5/30/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ListAppTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct PhotoResources {
        static let photo1 = "RecordButton"
        static let photo2 = "Echo"
        static let photo3 = "Reverb"
    }
    
    struct AppNames {
        static let PITCH_PERFECT = "Pitch Perfect"
        static let MEME_1 = "Meme 1.0"
        static let MEME_2 = "Meme 2.0"
    }
    
    struct SegueId {
        static let PITCH_PERFECT = "startRecording"
        static let MEME_1 = "Meme 1.0"
        static let MEME_2 = "Meme 2.0"
    }
    
    let cellReuseIdentifier = "cell"
    var appNames = [AppName]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        loadAppNames()
    }
    
    private func loadAppNames(){
        
        
        let app1 : AppName = AppName(name: AppNames.PITCH_PERFECT, image: UIImage(named: PhotoResources.photo1))
        let app2 : AppName = AppName(name: AppNames.MEME_1, image: UIImage(named: PhotoResources.photo2))
        let app3 : AppName = AppName(name: AppNames.MEME_2, image: UIImage(named: PhotoResources.photo3))
        
        appNames += [app1, app2, app3]
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? AppViewCell else {
            fatalError("The dequeued cell is not an instance of AppViewCell.")
        }
        
        // Fetches the appropriate app for the data source layout.
        let appItem = appNames[indexPath.row]
        
        cell.appLabel?.text = appItem.name
        cell.appImage?.image = appItem.photo
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let cell = tableView.cellForRow(at: indexPath) as? AppViewCell {
            if cell.appLabel?.text == AppNames.PITCH_PERFECT {
                performSegue(withIdentifier: SegueId.PITCH_PERFECT, sender: nil)
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
