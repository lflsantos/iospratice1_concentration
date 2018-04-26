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
    
    private(set) var flipCount = 0
    private var themes = ["🐶🐱🐭🦊🐼🐨🐯🦁🐮🐷🐸🐵",
                          "🍏🍐🍊🍎🍋🍌🍉🍇🍓🍈🍒🍑🍍",
                          "⚽️🏀🏈⚾️🥊🏓🎾🏐🏉🎱🏸",
                          "🚗🚕🚌🚲🛵🚃🚂🛩🚀🚁⛴"]
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let  card = Card()
            cards += [card, card]
        }
    }

    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index range")
        flipCount += 1
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
    
    func restartGame(){
        for index in cards.indices{
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        indexOfFaceUpCard = nil
        flipCount = 0
    }
    
    func getRandomTheme() -> String{
        let rand = (themes.count-1).arc4Random
        return themes[rand]
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}


