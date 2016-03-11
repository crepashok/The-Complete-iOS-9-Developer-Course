//
//  ViewController.swift
//  Lesson-73
//
//  Created by Pavlo Cretsu on 3/11/16.
//  Copyright © 2016 Pasha Cretsu. All rights reserved.
//

import UIKit

let playerNoughtID = 1

let playerCrossID = 2

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    var activePlayer = playerNoughtID
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var isGameActive = true
    
    let winningCombinations = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        if gameState[sender.tag] == 0 && isGameActive == true {
            
            gameState[sender.tag] = activePlayer
            
            sender.setImage(UIImage(named: (activePlayer == playerNoughtID) ? "nought.png" : "cross.png"), forState: .Normal)
            
            activePlayer = (activePlayer == playerNoughtID) ? playerCrossID : playerNoughtID
            
            for combination in winningCombinations {
            
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                
                    if gameState[combination[0]] == playerNoughtID {
                        
                        endGameWithMessage("Noughts has won!")
                        
                    } else {
                        
                        endGameWithMessage("Cross has won!")
                        
                    }
                    
                }
                
            }
            
            if isGameActive == true {
                
                isGameActive = false
                
                for buttonState in gameState {
                    
                    if buttonState == 0 {
                        
                        isGameActive = true
                    }
                    
                }
                
                if isGameActive == false {
                    
                    
                    endGameWithMessage("It's a draw!")
                    
                }
            
            }
            
        }
        
    }
    
    
    func endGameWithMessage(message: String) {
    
        isGameActive = false
        
        gameLabel.text = message
        
        gameLabel.hidden = false
        
        playAgainButton.hidden = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.gameLabel.center = CGPointMake(self.gameLabel.center.x + self.gameLabel.frame.size.width, self.gameLabel.center.y)
            
            self.playAgainButton.center = CGPointMake(self.gameLabel.center.x + self.gameLabel.frame.size.width, self.playAgainButton.center.y)
            
        })
        
    }

    
    @IBAction func playAgain(sender: UIButton) {
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activePlayer = playerNoughtID
        
        isGameActive = true
        
        hideResultLayer()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        hideResultLayer()
        
    }
    
    
    func hideResultLayer() {
        
        gameLabel.hidden = true
        
        playAgainButton.hidden = true
        
        gameLabel.center = CGPointMake(gameLabel.center.x - gameLabel.frame.size.width, gameLabel.center.y)
        
        playAgainButton.center = CGPointMake(gameLabel.center.x - gameLabel.frame.size.width, playAgainButton.center.y)
        
        var buttonToClear:UIButton
        
        for var i = 0; i < 9; i++ {
            
            let tempView = view.viewWithTag(i)
            
            if ((tempView?.isKindOfClass(UIButton)) == true) {
                
                buttonToClear = tempView as! UIButton
                
                buttonToClear.setImage(nil, forState: .Normal)
            }
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }


}

