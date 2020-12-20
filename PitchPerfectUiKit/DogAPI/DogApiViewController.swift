//
//  DogApiViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 9/19/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class DogApiViewController: UIViewController {
    
    @IBOutlet weak var loadImgBtn: UIButton!
    @IBOutlet weak var dogImg: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    static var breedDogList : [String:[String]] = [:]
    static var selectedBreed = "poodle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        loadBreeedNames()
    }
    
    func loadBreeedNames() {
        let url = URLComponents.init(string: DogService.DOG_BREEDS.rawValue)?.url
        URLSession.shared.dataTask(with: url!) {
            (data, urlResponse, error) in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let dogBreed = try decoder.decode(DogBreed.self, from: data)
                DogApiViewController.breedDogList = dogBreed.breeds
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    @IBAction func loadRandomImg(_ sender: Any) {
        
        let url = URLComponents.init(string: String(format: DogService.DOG_SELECTION_BREED_FORMAT.rawValue, DogApiViewController.selectedBreed))?.url
        DogService.requestRandomImage(url: url!) {
            (dogImage, error) in
            
            guard let dogImage = dogImage else {
                print(error!)
                return
            }
            
            self.loadImageFromCodableClass(dogImage)
        }
    }
    
    private func loadImageFromCodableClass(_ dogImage: DogImage){
        guard let imageUrl = URLComponents.init(string: dogImage.message)?.url else { return }
        
        URLSession.shared.dataTask(with: imageUrl) {
            (data, urlResponse, error) in
            
            guard let data = data else { return }
            
            let downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                //Update the image view
                self.dogImg.image = downloadedImage
            }
        }.resume()
    }
    
    /**
     * In the old times this was used to manually decode JSON
     */
    private func loadJsonOldWay(_ data: Data) {
        print(data)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: Any]
            let url = json["message"] as! String
            print(url)
        } catch {
            print(error)
        }
    }
}


extension UIViewController: UIPickerViewDataSource, UIPickerViewDelegate {
     
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DogApiViewController.breedDogList.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApiViewController.selectedBreed = Array(DogApiViewController.breedDogList.keys)[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(DogApiViewController.breedDogList.keys)[row]
    }
}
