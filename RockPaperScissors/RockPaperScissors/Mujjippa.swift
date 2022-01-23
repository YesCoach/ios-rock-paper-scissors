//
//  Mujjippa.swift
//  RockPaperScissors
//
//  Created by yun on 2022/01/23.
//

import Foundation

final class Mukjjippa: RockScissorsPaper {
    override func choiceUserHand() -> Hand? {
        print("[\(gameTurn)턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :", terminator: " ")
        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print(Message.invaild)
            gameTurn = Turn.convert(gameTurn)
            return choiceUserHand()
        }
        
        switch userInput {
        case 1:
            return Hand.rock
        case 2:
            return Hand.scissors
        case 3:
            return Hand.paper
        default:
            return Hand(rawValue: 0)
        }
    }

    func startGame() -> Bool {
        guard let userHand = choiceUserHand() else {
            return false
        }
        
        guard let result = try? compare(userHand: userHand, computerHand: generateComputerHand()) else {
            return false
        }
        
        switch result {
        case .draw:
            print("\(gameTurn) 승리!")
            return true
        case .lose:
            gameTurn = Turn.convert(gameTurn)
            print("\(gameTurn)의 턴입니다.")
            return startGame()
        case .win:
            print("\(gameTurn)의 턴입니다.")
            return startGame()
        }
    }
}

