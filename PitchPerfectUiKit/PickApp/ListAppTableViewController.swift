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
        static let RECORD_IMG = "RecordButton"
        static let DEFAULT_PHOTO = "LowPitch"
        static let MEME_ONE = "Meme"
    }
    
    struct AppNames {
        static let PITCH_PERFECT = "Pitch Perfect"
        static let CLICK_COUNTER = "Click Counter"
        static let CLICK_SWITCHER = "Click Switcher"
        static let MODAL_NAVIGATION = "Modal Navigation"
        static let ROCK_SCISSORS_PAPER = "Game RSP"
        static let MEME_1 = "Meme 1.0"
        static let MEME_2 = "Meme 2.0"
    }
    
    struct SegueId {
        static let PITCH_PERFECT = "startRecording"
        static let CLICK_COUNTER = "clickCounter"
        static let COLOR_SWITCHER = "clickColorSwitcher"
        static let MODAL_NAVIGATION = "clickModalNav"
        static let ROCK_SCISSORS_PAPER = "clickRSP"
        static let MEME_1 = "Meme1"
        static let MEME_2 = "Meme2"
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
        
        let app1 : AppName = AppName(name: AppNames.PITCH_PERFECT, image: UIImage(named: PhotoResources.RECORD_IMG))
        let app2 : AppName = AppName(name: AppNames.CLICK_COUNTER, image: UIImage(named: PhotoResources.DEFAULT_PHOTO))
        let app3 : AppName = AppName(name: AppNames.CLICK_SWITCHER)
        let app4 : AppName = AppName(name: AppNames.MODAL_NAVIGATION)
        let app5 : AppName = AppName(name: AppNames.ROCK_SCISSORS_PAPER)
        let app6 : AppName = AppName(name: AppNames.MEME_1, image: UIImage(named: PhotoResources.MEME_ONE))
        let app7 : AppName = AppName(name: AppNames.MEME_2, image: UIImage(named: PhotoResources.DEFAULT_PHOTO))
        
        appNames += [app1, app2, app3, app4, app5, app6, app7]
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
            
            switch cell.appLabel?.text {
            case AppNames.PITCH_PERFECT:
                performSegue(withIdentifier: SegueId.PITCH_PERFECT, sender: nil)
            case AppNames.CLICK_COUNTER:
                performSegue(withIdentifier: SegueId.CLICK_COUNTER, sender: nil)
            case AppNames.CLICK_SWITCHER:
                performSegue(withIdentifier: SegueId.COLOR_SWITCHER, sender: nil)
            case AppNames.MODAL_NAVIGATION:
                performSegue(withIdentifier: SegueId.MODAL_NAVIGATION, sender: nil)
            case AppNames.ROCK_SCISSORS_PAPER:
                performSegue(withIdentifier: SegueId.ROCK_SCISSORS_PAPER, sender: nil)
            case AppNames.MEME_1:
                performSegue(withIdentifier: SegueId.MEME_1, sender: nil)
            case AppNames.MEME_2:
                performSegue(withIdentifier: SegueId.MEME_2, sender: nil)
            default:
                print("Unkonwn selection.")
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
