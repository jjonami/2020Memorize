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
    
    //mutating : struct의 method가 struct 내부에서 data를 수정 할떄는 [mutating] keyword를 선언 해주어야함
    //다른 struct API를 보고 mutating이 있느냐 없느냐에 따라서, 원래 struct 내부의 값을 변경 하는 API 인지, 아닌지 유추할 수 있다
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return 0 // TODO : bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    //Identifiable : 식별이 가능하도록 하는 protocol
    //id 값의 비교를 통해서 각 Card를 식별할 수 있다
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMached: Bool = false
        var content: CardContent
        var id: Int
    }
}
