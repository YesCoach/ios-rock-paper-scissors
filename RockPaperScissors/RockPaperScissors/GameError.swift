//
//  GameError.swift
//  RockPaperScissors
//
//  Created by yun on 2022/01/23.
//

import Foundation

enum GameError: Error, CustomStringConvertible {
    case emptyCollection
    
    var description: String {
        switch self {
        case .emptyCollection:
            return "열거형이 비어있어요"
        }
    }
}
