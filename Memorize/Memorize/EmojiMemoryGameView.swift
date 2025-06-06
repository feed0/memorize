//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 23/05/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject
    var viewModel: EmojiMemoryGame

    var body: some View {
 
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding()
        }
    }
    
    var cards: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
         .foregroundColor(.orange)
    }
    
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    let cornerRadius = 20.0
    let lineWidth = 2.0
    let fontSize = 80.0
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        
        ZStack {
            
            let base = RoundedRectangle(cornerRadius: cornerRadius)
                            
            Group {
                
                base.fill(.white)
                base.strokeBorder(lineWidth: lineWidth)
                Text(card.content)
                    .font(.system(size: fontSize))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
