//
//  TableMemeViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/7/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class TableMemeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    //Creating from the appliction delegate.
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memesTwo
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as? MemeTableViewCell else {
            fatalError("The dequeued cell is not an instance of AppViewCell.")
        }
        
        let meme = memes[indexPath.row]
        cell.memeImg.image = meme.memedImage
        cell.memeLabel.text = "\(meme.topText) \(meme.bottomText)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! DetailMemeViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
