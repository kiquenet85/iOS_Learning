//
//  ModelGameRSP.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/5/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import Foundation

struct HistoryGame {
    let winner: RSPGame.Winner
    let play: RSPGame.Play
    
    init(winner: RSPGame.Winner, play: RSPGame.Play) {
        self.winner = winner
        self.play = play
    }
    
    func getDetail() -> String {
        var result = ""
        switch winner {
            
        case .PLAYER:
            result.append(contentsOf: "Player won")
        case .SYSTEM:
            result.append(contentsOf: "Player loosed")
        case .PARITY:
            result.append(contentsOf: "It was a tie")
        }
        
        switch play {
        case .ROCK:
              result.append(contentsOf: " using ROCK")
        case .SCISSOR:
              result.append(contentsOf: " using SCISSOR")
        case .PAPER:
              result.append(contentsOf: " using PAPER")
        case .ROCK_OVER_SCISSOR:
              result.append(contentsOf: " using ROCK_OVER_SCISSOR")
        case .SCISSOR_OVER_PAPER:
              result.append(contentsOf: " using SCISSOR_OVER_PAPER")
        case .PAPER_OVER_ROCK:
              result.append(contentsOf: " using PAPER_OVER_ROCK")
        }
        return result
    }
}

class RSPGame {
    
    let prefixImagePath = #"GameRSP/"#
    var winner = Winner.PARITY
    var detailPlayed = Play.ROCK
    var historyGame: [HistoryGame] = []
    
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
        historyGame.insert(HistoryGame(winner: self.winner, play: self.detailPlayed), at: historyGame.count)
    }
}
