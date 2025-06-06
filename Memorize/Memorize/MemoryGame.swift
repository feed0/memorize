//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 02/06/25.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: [Card]
    
    init(with noCardPairs: Int, cardContentFactory: (Int) -> CardContent) {
        
        cards = []
        
        for pairIndex in 0 ..< max(2, noCardPairs) {
            
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}
