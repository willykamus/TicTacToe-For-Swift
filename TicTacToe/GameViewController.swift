//
//  ViewController.swift
//  TicTacToe
//
//  Created by William Ching on 2019-05-14.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameActive = true
    var activeUser = 1
    var board = [0,0,0,0,0,0,0,0,0]
    var computerPossibleChoices = [1,2,3,4,5,6,7,8,9]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.layer.cornerRadius = 20
        resetButton.layer.masksToBounds = true
        resetButton.isHidden = true
        winnerLabel.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func action(_ sender: UIButton) {
        
        //Check which user played, and set its corresponding picture
        //For now, we will say that the user1 value is 1 and play "Cross" and user2 is 2 and play "Nought"
        //The value of each user is to fill the array with their choices for later check who wins

        if gameActive {
            
            print("button I choose \(sender.tag-1)")
            board[sender.tag - 1] = 1
            sender.setImage(UIImage(named: "Cross"), for: .normal)
            
            for i in 0..<computerPossibleChoices.count {
                if computerPossibleChoices[i] == (sender.tag){
                    computerPossibleChoices.remove(at: i)
                    print(computerPossibleChoices)
                    break
                }
            }
            
            sender.isEnabled = false
            //print(board)
            checkResult()
            activeUser = 2
            
            //computer plays
            //check if there are available options to play
            if computerPossibleChoices.count > 0 && gameActive {
                
                let computerPick = randomPick()
                let button = view.viewWithTag(computerPick) as! UIButton
                button.setImage(UIImage(named: "Nought"), for: .normal)
                board[computerPick-1] = 2
                button.isEnabled = false
                checkResult()
                activeUser = 1
            }

        }

    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        
        gameActive = true
        activeUser = 1
        board = [0,0,0,0,0,0,0,0,0]
        computerPossibleChoices = [1,2,3,4,5,6,7,8,9]
        winnerLabel.isHidden = true
        
        for i in 1...board.count {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
            button.isEnabled = true
        }
        
        resetButton.isHidden = true
        
    }
    
}

extension GameViewController {
    
    private func checkWin() -> Bool{
        
        // Need to check all the combinations and return true if we found one valid
        for combination in winningCombinations {
            
            if board[combination[0]] != 0 {
                
                if board[combination[0]] == board[combination[1]] && board[combination[0]] == board[combination[2]]{
                    return true
                }
            }
            
        }
        
        return false
    }
    
    private func checkDraw() -> Bool {
        
        for i in board {
            if i == 0 { return false }
        }
        
        return true
        
    }
    
    private func checkResult() {
        
        var message = ""
        
        if checkWin() {
            if activeUser == 1 {
                message = "Cross Wins"
                displayResult(message, #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
            } else {
                message = "Nought Wins"
                displayResult(message, #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
            }
            gameActive = false
            resetButton.isHidden = false
        } else if checkDraw() {
            message = "It is a draw"
            resetButton.isHidden = false
            displayResult(message, #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        }
        
    }
    
    private func randomPick() -> Int {
        
        let randomIndex = Int.random(in: 0..<computerPossibleChoices.count)
        print("random pick \(randomIndex)")
        let tag = computerPossibleChoices[randomIndex]
        computerPossibleChoices.remove(at: randomIndex)
        print(computerPossibleChoices)
        return tag
    
    }
    
    private func displayResult(_ message:String, _ color:UIColor) {
        
        winnerLabel.textColor = color
        winnerLabel.isHidden = false
        winnerLabel.text = message
        winnerLabel.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.winnerLabel.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: nil)
        
    }
    
}

