//
//  ContentView.swift
//  Memorize
//
//  Created by Bob Faist on 3/22/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount = 3
    
    var emojis = ["😄", "🦊", "🐝", "🐶", "🐹", "🦄", "🐞", "🦆", "🐙", "🐳", "🐆"]
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }.font(.largeTitle)
    }
    
    var cardRemover: some View {
        makeAdjuster(at: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        makeAdjuster(at: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func makeAdjuster(at offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }.disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    @State var isFaceUp = true
    
    let content: String
    
    private let baseView = RoundedRectangle(cornerRadius: 15.0)
    
    var body: some View {
        ZStack {
            Group {
                baseView.fill(.white)
                baseView.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1.0 : 0.0)
            baseView.opacity(isFaceUp ? 0.0 : 1.0)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
