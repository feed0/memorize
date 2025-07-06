//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 02/06/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    
    init(numberOfCardPairs: Int, cardContentFactory: (Int) -> CardContent) {
        
        cards = []
        
        for pairIndex in 0 ..< max(2, numberOfCardPairs) { /// Ensures at least 2 card pairs
            
            let content = cardContentFactory(pairIndex) /// Returns an emoji at pairIndex
            
            let units = ["a", "b"]
            
            for unit in units { /// Appends a pair of emoji cards
                cards.append(Card(
                    content: content,
                    id: "\(pairIndex + 1)-\(unit)"
                ))
            }
        }
    }
    
    // MARK: - Computed properties
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // MARK: - Intents
    
    mutating func shuffle() {
        
        cards.shuffle()
        
        print("""
            [SHUFFLE!] \\/''\\/''\\/''
            \(cards)
            [SHUFFLE!] /\\../\\../\\..
            
            """)
    }
    
    mutating func choose(_ card: Card) { // TODO: - change finding a Card by id to finding by memory address hex
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
        
        print("""
              [Chosen!] \\/''\\/''\\/''
              \(card) \(card.isFaceUp ? "\t| UP" : "\t| DOWN")
              [Chosen!] /\\../\\../\\..
              
              """)
    }
    
    // MARK: - Card
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
            """
            Card [\(id)]: \(content) \t| \(isFaceUp ? "up" : "down") \t| \(isMatched ? "matched" : "unmatched")
            """
        }
    }
}

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
