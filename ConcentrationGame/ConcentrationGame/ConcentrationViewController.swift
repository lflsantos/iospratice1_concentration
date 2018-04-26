//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Lucas Santos on 23/04/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1)/2
    }
    
    
    
    private var emojiChoices : String = ""
    
    private var emoji = [Card : String]()
    
    @IBOutlet weak var newGameButton: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        emojiChoices = game.getRandomTheme()
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateFlipCountLabel()
            updateViewFromModel()
        }else{
            print("choosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game.restartGame()
        emoji = [Card : String]()
        emojiChoices = game.getRandomTheme()
        updateViewFromModel()
        updateFlipCountLabel()
    }
    
}

extension Int{
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}










