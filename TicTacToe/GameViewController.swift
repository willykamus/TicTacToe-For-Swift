//
//  ViewController.swift
//  TicTacToe
//
//  Created by William Ching on 2019-05-14.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var gameStates = [0,0,0,0,0,0,0,0,0]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func action(_ sender: UIButton) {
        
        if gameStates[sender.tag] == 0 {
            
            gameStates[sender.tag] = 1
            
            sender.setImage(UIImage(named: "Cross"), for: .normal)

            sender.isEnabled = false
            
        }
        
    }
    
}

