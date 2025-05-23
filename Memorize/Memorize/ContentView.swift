//
//  ContentView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 23/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount: Int = 4
    let emojis = ["🦄", "🐇", "🐢", "🦎", "🦖", "🦕", "🦓", "🦔"]

    var body: some View {
 
        VStack {
            
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            
            ForEach(0 ..< cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        
        HStack {
            
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    
    let content: String
    let cornerRadius = 20.0
    let lineWidth = 2.0
    @State var isFaceUp = true
    
    var body: some View {
        
        ZStack {
            
            let base = RoundedRectangle(cornerRadius: cornerRadius)
                            
            Group {
                
                base.fill(.white)
                base.strokeBorder(lineWidth: lineWidth)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
