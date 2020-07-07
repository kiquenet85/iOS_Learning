//
//  GameResultsRSPViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 6/14/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class ResultsRSPViewController: UIViewController {
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var resultGameLabel: UILabel!
    @IBOutlet weak var imageViewResult: UIImageView!
    
    var game : RSPGame?
    
    var selectedOption = RSPGame.SelectedOption.ROCK
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let game = self.game else {
            return
        }
        
        game.playRSP(playerUsing: selectedOption, systemUsing: RSPGame.SelectedOption.randomOption())
        
        switch (game.winner) {     
        case .PARITY:
            resultGameLabel.text = "it's A Tie"
            imageViewResult.image = UIImage(named: "itsATie")
        case .SYSTEM:
            resultGameLabel.text = "You loss"
            imageViewResult.image = UIImage(named: game.detailPlayed.rawValue)
        case .PLAYER:
            resultGameLabel.text = "You WIN!!!!"
            imageViewResult.image = UIImage(named: game.detailPlayed.rawValue)
        }
    }
    
    @IBAction func dismissOnModal(){
        self.dismiss(animated: true, completion: nil)
    }
}
