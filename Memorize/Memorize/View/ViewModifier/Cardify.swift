//
//  Cardify.swift
//  Memorize
//
//  Created by Felipe Campelo on 20/07/25.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    // MARK: - Properties
    
    let id: String
    let isDebugTextEnabled: Bool
    
    var isMatched: Bool
    var isFaceUp: Bool {
        rotation < Constants.Cardify.IsFaceUpRotation.threshold
    }
    
    // MARK: - Animation properties
    
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    // MARK: - Init
    
    init(id: String,
         isDebugTextEnabled: Bool,
         isMatched: Bool,
         isFaceUp: Bool) {
        self.id = id
        self.isDebugTextEnabled = isDebugTextEnabled
        self.isMatched = isMatched
        rotation = isFaceUp ? Constants.Cardify.IsFaceUpRotation.isUp : Constants.Cardify.IsFaceUpRotation.isDown
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        VStack {
            
            ZStack {
                face(for: content)
                back(for: content)
            }
            /// Matched
            .opacity(isMatched && !isFaceUp
                     ? Constants.Opacity.hide
                     : Constants.Opacity.show)
            .background()
            .rotation3DEffect(.degrees(rotation),
                              axis: Constants.Cardify.Rotation3dEffectAngles.yAxis)
            
            /// Card debug identifier
            if isDebugTextEnabled {
                Text(id)
                    .background()
            }
            
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    func face(for content: Content) -> some View {
        let base = RoundedRectangle(cornerRadius: Constants.Cardify.cornerRadius)
        
        base.strokeBorder(lineWidth: Constants.Cardify.lineWidth)
            .background(base.fill(.white))
            .overlay(content)
            .opacity(isFaceUp
                     ? Constants.Opacity.show
                     : Constants.Opacity.hide)
    }
    
    @ViewBuilder
    func back(for content: Content) -> some View {
        let base = RoundedRectangle(cornerRadius: Constants.Cardify.cornerRadius)

        base.fill()
            .opacity(isFaceUp
                     ? Constants.Opacity.hide
                     : Constants.Opacity.show)
    }
}

// MARK: - ViewModifier cardify extension

extension View {
    func cardify(
        isFaceUp: Bool = true,
        isDebugTextEnabled: Bool = false,
        id: String = "",
        isMatched: Bool = false
    ) -> some View {
        modifier(Cardify(id: id,
                         isDebugTextEnabled: isDebugTextEnabled,
                         isMatched: isMatched,
                         isFaceUp: isFaceUp))
    }
}
