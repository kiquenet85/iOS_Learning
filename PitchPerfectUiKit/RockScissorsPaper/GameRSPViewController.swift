//
//  GameRSPViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/13/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

/**
 The idea of the game
 rock: Only uses code to show results against System
 paper: uses segue to show results against System
 scissors: uses only story board and the prepareForSegue method to show results against system
 */
class GameRSPViewController: UIViewController {
    
    struct SegueIds{
        static let GAME_RESULTS = "GameResults"
    }
    
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var paperBtn: UIButton!
    @IBOutlet weak var scissorsBtn: UIButton!
    
    var selectedOption = RSPGame.SelectedOption.ROCK
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Rock button
    @IBAction func onlyCodeToShowResults(){
        let controller: ResultsRSPViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "GameResultsRSPViewController") as! ResultsRSPViewController
        controller.selectedOption = RSPGame.SelectedOption.ROCK
        present(controller, animated: true, completion: nil)
    }
    
    //Paper Button
    @IBAction func segueToShowResults(){
        selectedOption = RSPGame.SelectedOption.PAPER
        performSegue(withIdentifier: SegueIds.GAME_RESULTS, sender: nil)
    }
    
    //For Scissors Button i created an action on storyboard
    @IBAction func selectedScissors(_ sender: Any) {
        selectedOption = RSPGame.SelectedOption.SCISSOR
    }
    
    //Let's play Btn
    @IBAction func incorrectSegueLetsPlay(){
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueIds.GAME_RESULTS){
            //Paper btn or Scissors Btn
            let resultsRSPController = segue.destination as! ResultsRSPViewController
            resultsRSPController.selectedOption = selectedOption
        }
    }
}
