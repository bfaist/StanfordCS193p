//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Robert Faist on 3/25/24.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    private(set) var cards: [Card] = []
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp }).only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    mutating func choose(card: Card) {
        guard let cardIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        if !cards[cardIndex].isFaceUp && !cards[cardIndex].isMatched {
            if let checkIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[cardIndex].content == cards[checkIndex].content {
                    cards[cardIndex].isMatched = true
                    cards[checkIndex].isMatched = true
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = cardIndex
            }
            cards[cardIndex].isFaceUp = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        let id = UUID()
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}

extension Array {
    var only: Element? {
        self.count == 1 ? self.first : nil
    }
}
