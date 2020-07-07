//
//  ModelGameRSP.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/5/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation

class RSPGame {
    
    let prefixImagePath = #"GameRSP/"#
    var winner = Winner.PARITY
    var detailPlayed = Play.ROCK
    
    enum Winner {
        case PLAYER, SYSTEM, PARITY
    }
    
    enum Play : String {
        case ROCK = "rock",
        SCISSOR = "scissors",
        PAPER = "paper",
        ROCK_OVER_SCISSOR = "RockCrushesScissors",
        SCISSOR_OVER_PAPER = "ScissorsCutPaper",
        PAPER_OVER_ROCK = "PaperCoversRock"
    }
    
    enum SelectedOption : String{
        case ROCK = "ROCK", SCISSOR = "SCISSOR", PAPER = "PAPER"
        
        // This function randomly generates a system's play
        static func randomOption() -> SelectedOption {
            let options = ["ROCK", "PAPER", "SCISSOR"]
            let randomChoice = Int(arc4random_uniform(3))
            print(randomChoice)
            return SelectedOption(rawValue: options[randomChoice])!
        }
    }
    
    func playRSP(playerUsing optionPlayer: SelectedOption, systemUsing optionSystem: SelectedOption) {
        if optionPlayer == optionSystem {
            self.winner = Winner.PARITY
            switch optionSystem {     
            case .ROCK:
                detailPlayed = Play.ROCK
            case .SCISSOR:
                detailPlayed = Play.SCISSOR
            case .PAPER:
                detailPlayed = Play.PAPER
            }
        } else if optionPlayer == SelectedOption.ROCK {
            switch (optionSystem) {
            case .PAPER:
                self.winner = Winner.SYSTEM
                self.detailPlayed = Play.PAPER_OVER_ROCK
            default:
                self.winner = Winner.PLAYER
                self.detailPlayed = Play.ROCK_OVER_SCISSOR
            }
            
        } else if optionPlayer == SelectedOption.SCISSOR {
            switch (optionSystem) {
            case .ROCK:
                self.winner = Winner.SYSTEM
                self.detailPlayed = Play.ROCK_OVER_SCISSOR
            default:
                self.winner = Winner.PLAYER
                self.detailPlayed = Play.SCISSOR_OVER_PAPER
            }
        } else {
            switch (optionSystem) {
            case .SCISSOR:
                self.winner = Winner.SYSTEM
                self.detailPlayed = Play.SCISSOR_OVER_PAPER
            default:
                self.winner = Winner.PLAYER
                self.detailPlayed = Play.PAPER_OVER_ROCK
            }
        }
    }
}
