//
//  CollectionMemeViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/7/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class CollectionMemeViewController: UICollectionViewController {
    
    // MARK: Properties
    //Creating from the appliction delegate.
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memesTwo
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dimensionWidth : CGFloat
        var dimensionHeight : CGFloat
        
        let space:CGFloat = 3.0
        if view.frame.size.width > view.frame.size.height {
            dimensionWidth = (view.frame.size.width - (5 * space)) / 4.0
            dimensionHeight = (view.frame.size.height - (2 * space)) / 2.0
        } else {
            dimensionWidth = (view.frame.size.width - (2 * space)) / 2.0
            dimensionHeight = (view.frame.size.height - (5 * space)) / 4.0
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionWidth, height: dimensionHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            self.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Data Sources
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        // Set the meme image
        cell.memeImage.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! DetailMemeViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
