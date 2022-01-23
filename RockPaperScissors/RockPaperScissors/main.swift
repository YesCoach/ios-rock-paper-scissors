//
//  RockPaperScissors - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

var rockScissorsPaper = RockScissorsPaper()
var mujjippa = Mukjjippa()

while true {
    guard let rockPaperScissorsResult = rockScissorsPaper.startGame() else {
        break
    }
    
    rockScissorsPaper.gameTurn = rockPaperScissorsResult
    
    if !mujjippa.startGame() {
        print(Message.end)
        break
    }
}

