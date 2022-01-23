//
//  RockScissorsPaper.swift
//  RockPaperScissors
//
//  Created by yun on 2022/01/23.
//
import Foundation

class RockScissorsPaper {
    var gameTurn = Turn.userTurn
    
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
            } else {
                return .userTurn
            }
        }
    }
    
    func choiceUserHand() -> Hand? {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
        guard let userInput = (readLine().flatMap{ Int($0) }), (0...3).contains(userInput) else {
            print(Message.invaild)
            return choiceUserHand()
        }
        
        return Hand(rawValue: userInput)
    }

    func generateComputerHand() throws -> Hand {
        guard let randomHand = Hand.allCases.randomElement() else {
            throw GameError.emptyCollection
        }
        
        return randomHand
    }
    
    func compare(userHand: Hand, computerHand: Hand) -> Result {
        let result = Result.compareHand(userHand, with: computerHand)
        return result
    }
    
    func startGame() -> Turn? {
        var firstResult: Result
        
        repeat {
            guard let userHand = choiceUserHand() else {
                print(Message.end)
                return nil
            }

            firstResult = try! compare(userHand: userHand, computerHand: generateComputerHand())
            print(firstResult)
        } while firstResult == Result.draw
        
        return (firstResult == .win) ? Turn.userTurn : .computerTurn
    }
}
