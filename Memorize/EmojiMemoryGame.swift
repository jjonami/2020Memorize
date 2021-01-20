//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/18.
//

import SwiftUI

//ViewModel

//ObservableObject : class에만 쓰일 수 있다
//[Publisher]
//var objectWillChange: ObservableObjectPublisher
//something change -> call the function send() -> publish the world something change

class EmojiMemoryGame: ObservableObject {
    //@Published : ProperyWrapper
    //Publisher로 사용할 수 있게 만든다
    //{model}이 change 되면 매전 objectWillChange.send()를 호출
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🐶","🐹","🐰"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        self.model.cards
    }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        self.model.choose(card: card)
    }
    
}
