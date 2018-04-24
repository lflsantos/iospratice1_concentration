//
//  Card.swift
//  ConcentrationGame
//
//  Created by Lucas Santos on 23/04/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    var hashValue: Int{
        return identifier
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    private var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
