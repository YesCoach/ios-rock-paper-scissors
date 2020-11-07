//
//  Card.swift
//  RockPaperScissors
//
//  Created by 강인희 on 2020/11/04.
//

import Foundation

struct Card {
    /// 카드패
    var cardIdx: Int
    /// 승패결정확인용 배열
    let checkWinOrLose = [2,3,1]

    
    init() {
        self.cardIdx = 0
    }
    
    /// - Parameter computerIdx: 컴퓨터 카드패
    /// - Parameter executedGame: 실행된 게임의 종류 (가위바위보 / 묵찌빠)
    ///
    /// - Returns: True or False (해당 카드 객체의 승 또는 패)
    func didWin(against computerIdx: Int, on executedGame: GameName) -> Bool {
        var myIdx = self.cardIdx
        var computerIdx = computerIdx
        
        if executedGame == .묵찌빠 {
            let temp = myIdx
            myIdx = computerIdx
            computerIdx = temp
        }
    
        guard 0 <= myIdx - 1, myIdx-1 < checkWinOrLose.count  else{
            fatalError("입력된 값이 정확하지 않습니다.")
        }
        
        if checkWinOrLose[myIdx - 1] == computerIdx {
            return false
        }else{
            return true
        }
    }
}


