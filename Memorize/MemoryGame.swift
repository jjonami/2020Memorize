//
//  MemoryGame.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/18.
//

import Foundation

//Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) : read-only
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    //mutating : struct의 method가 struct 내부에서 data를 수정 할떄는 [mutating] keyword를 선언 해주어야함
    //다른 struct API를 보고 mutating이 있느냐 없느냐에 따라서, 원래 struct 내부의 값을 변경 하는 API 인지, 아닌지 유추할 수 있다
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMached {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMached = true
                    cards[potentialMatchIndex].isMached = true
                }
                cards[chosenIndex].isFaceUp = true
            }else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
