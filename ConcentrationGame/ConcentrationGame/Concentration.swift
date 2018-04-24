//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Lucas Santos on 23/04/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfFaceUpCard: Int?{
        get{
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index range")
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let  card = Card()
            cards += [card, card]
        }
        
        //shuffle cards
    }
    
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
