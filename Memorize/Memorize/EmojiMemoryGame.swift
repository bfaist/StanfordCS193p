//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Robert Faist on 3/25/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["😄", "🦊", "🐝", "🐶", "🐹", "🦄", "🐞", "🦆", "🐙", "🐳", "🐆"]
   
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        MemorizeGame(numberOfPairsOfCards: 10) { pairIndex in
            guard emojis.indices.contains(pairIndex) else { return "⁉️" }
            return emojis[pairIndex]
        }
    }
    
    var cards: [MemorizeGame<String>.Card] {
        model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card: card)
    }
}
