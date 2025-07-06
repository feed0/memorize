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
            
            CardsScrollView
            ShuffleButtonView
        }
        .padding()
    }
    
    var cards: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            
            ForEach(viewModel.cards) { card in
                
                VStack {
                
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    
//                    Text(card.id)
                }
            }
        }
         .foregroundColor(.orange)
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    private var CardsScrollView: some View {
        
        ScrollView {
            cards
                .animation(.bouncy, value: viewModel.cards)
        }
    }
    
    @ViewBuilder
    private var ShuffleButtonView: some View {
        
        Button("Shuffle") {
            viewModel.shuffle()
        }
        .padding()
    }

}

// MARK: - CardView

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    let cornerRadius = 23.0
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
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
