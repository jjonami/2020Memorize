//
//  MemoryGame.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/18.
//

import Foundation

//Model
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMached: false, content: content))
            cards.append(Card(isFaceUp: <#T##Bool#>, isMached: <#T##Bool#>, content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMached: Bool
        var content: CardContent
    }
}
