//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 03/06/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // MARK: - Statics
    private static let emojis = ["🦄", "🐇", "🐢", "🦎", "🦖", "🦕", "🦓", "🦔"]
    
    private static let emojiPairsCount = 12
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame(cardPairsCount: emojiPairsCount) {
            
            pairIndex in /// model.init(..., cardContentFactory: (Int) -> CardContent)
            
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "❌"
            }
        }
    }
    
    // MARK: - Model
    
    @Published
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
