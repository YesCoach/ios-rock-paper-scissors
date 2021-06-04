//
//  RockPaperScissors - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

class RockScissorsPaper {
    enum Hand : Int, CaseIterable {
        case scissors = 1
        case rock = 2
        case paper = 3
    }

    enum Result: CustomStringConvertible {
        case win
        case draw
        case lose

        var description: String {
            switch self {
            case .win:
                return "이겼습니다!"
            case .draw:
                return "비겼습니다!"
            case .lose:
                return "졌습니다!"
            }
        }
        static func compareHand(_ user: Hand, with computer: Hand) -> Result {
            switch (user, computer) {
            case let (x, y) where x == y:
                return .draw
            case (.scissors, let x):
                return x == .rock ? .lose : .win
            case (.rock, let x):
                return x == .paper ? .lose : .win
            case (.paper, let x):
                return x == .scissors ? .lose : .win
            }
        }
    }
    
    enum Turn: CustomStringConvertible {
        case userTurn
        case computerTurn
        
        var description: String {
            switch self {
            case .userTurn:
                return "사용자"
            case .computerTurn:
                return "컴퓨터"
            }
        }
        
        static func convert(_ turn: Turn) -> Turn {
            if turn == .userTurn {
                return .computerTurn
            }
            else {
                return .userTurn
            }
        }
    }

    func choiceUserHand() -> Hand? {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
        let userInputArray: [Int] = [0, 1, 2, 3]
        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            
            return choiceUserHand()
        }
        return Hand(rawValue: userInput)
    }

    func computerHand() -> Hand {
        if let randomHand = Hand.allCases.randomElement() {
            return randomHand
        } else {
            return computerHand()
        }
    }

    func compare(userHand: Hand, computerHand: Hand) -> Result {
        let gameResult = Result.compareHand(userHand, with: computerHand)
        return gameResult
    }
    
    func startRockScissorsPaper() -> Turn? {
        var gameResult: Result
        repeat {
            guard let userHand = choiceUserHand() else {
                print("게임 종료")
                return nil
            }
            gameResult = compare(userHand: userHand, computerHand: computerHand())
            print(gameResult.description)
        } while gameResult == Result.draw
        return (gameResult == .win) ? Turn.userTurn : .computerTurn
    }
}

class MukJjiPpa: RockScissorsPaper {
    var gameTurn: Turn = .userTurn
    
    override func choiceUserHand() -> Hand? {
        print("[\(gameTurn)턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :", terminator: " ")
        let userInputArray: [Int] = [0, 1, 2, 3]
        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
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
    
    func startMukJjiPpa() -> Bool{
        guard let userHand = choiceUserHand() else {
            return false
        }
        let gameResult = compare(userHand: userHand, computerHand: computerHand())
        switch gameResult {
        case .draw:
            print("\(gameTurn) 승리!")
            return true
        case .lose:
            gameTurn = Turn.convert(gameTurn)
            fallthrough
        case .win:
            print("\(gameTurn)의 턴입니다")
            return startMukJjiPpa()
        }
    }
}

let firstGame = RockScissorsPaper()
var secondGame = MukJjiPpa()

while true {
    guard let firstGameResult = firstGame.startRockScissorsPaper() else {
        break
    }
    secondGame.gameTurn = firstGameResult
    if !secondGame.startMukJjiPpa() {
        print("게임 종료")
        break
    }
}
