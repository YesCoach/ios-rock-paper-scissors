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

enum Result: String {
    case win = "이겼습니다!"
    case draw = "비겼습니다!"
    case lose = "졌습니다!"
    
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

struct RockScissorsPaper {
    private func choiceUserHand() -> Hand? {
        let userInputArray: Array<Int> = [0, 1, 2, 3]
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")

        guard let userInput = (readLine().flatMap{ Int($0) }), userInputArray.contains(userInput) else {
            print("잘못된 입력입니다. 다시 입력해주세요")
            return choiceUserHand()
        }

        return Hand(rawValue: userInput)
    }

    private func computerHands() -> Hand {
        if let randomHand = Hand.allCases.randomElement() {
            return randomHand
        } else {
            return computerHands()
        }
    }

    private func compare(userHand: Hand, computerHand: Hand) {
        let result = computerHand.rawValue - userHand.rawValue
    
        switch result {
        case 0:
            print(Result.draw.rawValue)
            startGame()
        case 1, -2:
            print(Result.lose.rawValue)
        case -1, 2:
            print(Result.win.rawValue)
        default:
            break
        }
    }

    func startGame() {
        guard let userHand = choiceUserHand() else {
            print("게임 종료")
            return
        }

        compare(userHand: userHand, computerHand: computerHands())
    }
}

var rockScissorsPaper = RockScissorsPaper()
rockScissorsPaper.startGame()

