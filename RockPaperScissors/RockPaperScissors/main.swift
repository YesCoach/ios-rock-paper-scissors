//
//  RockPaperScissors - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

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

struct RockScissorsPaper {
    private func choiceUserHand() -> Hand? {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
        let userInputArray: [Int] = [0, 1, 2, 3]
        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print("잘못된 입력입니다. 다시 입력해주세요")
            
            return choiceUserHand()
        }
        return Hand(rawValue: userInput)
    }

    private func computerHand() -> Hand {
        if let randomHand = Hand.allCases.randomElement() {
            return randomHand
        } else {
            return computerHand()
        }
    }
    
//    private mutating func compare(userHand: Hand, computerHand: Hand){
//        let result = Result.compareHand(userHand, with: computerHand)
//        switch result {
//        case .draw:
//            print(Result.draw)
//            if let turn = gameTurn{
//                print(turn,"의 승리!", separator: "")
//                return
//            } else {
//            startGame()
//            }
//
//        case .win:
//            print(Result.win)
//            if var turn = gameTurn {
//                turn = Turn.convert(turn)
//                gameTurn = turn
//                secondGame(attack: turn)
//            } else {
//                gameTurn = .userTurn
//                secondGame(attack: .userTurn)
//            }
//
//        case .lose:
//            print(Result.lose)
//            if var turn = gameTurn {
//                turn = Turn.convert(turn)
//                gameTurn = turn
//                secondGame(attack: turn)
//            } else {
//                gameTurn = .computerTurn
//                secondGame(attack: .computerTurn)
//            }
//        }
//    }
    private func compare(userHand: Hand, computerHand: Hand) -> Result{
           let result = Result.compareHand(userHand, with: computerHand)
           switch result {
           case .draw:
                print(Result.draw)
                
           case .lose:
                print(Result.lose)
            
           case .win:
                print(Result.win)
           }
            return result
    }
    
//    private mutating func choiceSecondHand() -> Hand? {
//        guard let turn = gameTurn else {
//            print("아직 게임이 진행되지 않았네요")
//            return choiceUserHand()
//        }
//
//        print("[\(turn)턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :", terminator: " ")
//        let userInputArray: [Int] = [0, 1, 2, 3]
//        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
//            print("잘못된 입력입니다. 다시 입력해주세요")
//            gameTurn = Turn.convert(turn)
//            return choiceSecondHand()
//        }
//        switch userInput{
//        case 1:
//            return Hand.rock
//        case 2:
//            return Hand.scissors
//        case 3:
//            return Hand.paper
//        default:
//            return Hand(rawValue: 0)
//        }
//  }
//    private mutating func secondGame(){
//        guard let userHand = choiceSecondHand() else {
//            print("게임 종료")
//            return
//        }
//        let result = compare(userHand: userHand, computerHand: computerHand())
//        if result == .draw {
//            return
//        } else {
//            gameTurn = Turn.convert(gameTurn)
//        }
//    }
    //묵찌빠 비교 함수 -> 해당 분기로 이동 1. 비기면 승리 출력하고 게임 종료, 2. 이기거나 질 경우 턴 넘기고 양쪽 손모양 생성 -> 묵찌빠 비교
    
    func startGame() -> Turn? {
        var firstResult: Result
        repeat {
            guard let userHand = choiceUserHand() else {
                print("게임 종료")
                return nil
            }
            firstResult = compare(userHand: userHand, computerHand: computerHand())
        } while firstResult == Result.draw
        let gameTurn = (firstResult == .win) ? Turn.userTurn : .computerTurn
        return gameTurn
    }
}

struct SecondGame {
    var gameTurn: Turn = .userTurn
    
    mutating func choiceUserHand() -> Hand? {
        print("[\(gameTurn)턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> :", terminator: " ")
        let userInputArray: [Int] = [0, 1, 2, 3]
        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print("잘못된 입력입니다. 다시 입력해주세요")
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
    
    func computerHand() -> Hand {
        if let randomHand = Hand.allCases.randomElement() {
            return randomHand
        } else {
            return computerHand()
        }
    }
    
    mutating func compare(userHand: Hand, computerHand: Hand, turn: Turn){
            gameTurn = turn
           let result = Result.compareHand(userHand, with: computerHand)
           switch result {
           case .draw:
                print(Result.draw)
                print("\(turn) 승리!")
           case .lose, .win:
                print(result.description)
                gameTurn = Turn.convert(gameTurn)
                gameStart()
           }
    }
    
    mutating func gameStart() {
        guard let userHand = choiceUserHand() else {
            print("게임 종료")
            return
        }
        compare(userHand: userHand, computerHand: computerHand(), turn: gameTurn)
    }
}

var firstGame = RockScissorsPaper()
let gameTurn = firstGame.startGame()
if let turn = gameTurn {
    var secondGame = SecondGame()
    secondGame.gameTurn = turn
    secondGame.gameStart()
}
