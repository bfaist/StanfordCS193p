//
//  ContentView.swift
//  Memorize
//
//  Created by Bob Faist on 3/22/24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }.foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    private let baseView = RoundedRectangle(cornerRadius: 15.0)
    
    var body: some View {
        ZStack {
            Group {
                baseView.fill(.white)
                baseView.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1.0 : 0.0)
            baseView.opacity(card.isFaceUp ? 0.0 : 1.0)
        }.opacity(card.isFaceUp || !card.isMatched ? 1.0 : 0.0)
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemoryGame())
}
