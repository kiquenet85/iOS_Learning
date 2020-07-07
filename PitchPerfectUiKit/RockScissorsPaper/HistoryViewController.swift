//
//  HistoryViewController.swift
//  PitchPerfectUiKit
//
//  Created by Nestor Diazgranados on 7/6/20.
//  Copyright © 2020 NesDupier. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var modelRSP: RSPGame? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (modelRSP != nil) ? modelRSP!.historyGame.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "HistoryCell")!
        
        if modelRSP != nil {
            let playDetail = modelRSP!.historyGame[indexPath.row]
            cell.textLabel!.text = playDetail.getDetail()
            if (playDetail.winner == RSPGame.Winner.PLAYER){
                cell.backgroundColor = UIColor.green
            } else if (playDetail.winner == RSPGame.Winner.SYSTEM){
                cell.backgroundColor = UIColor.red
            }
        }
        
        return cell
    }
}
