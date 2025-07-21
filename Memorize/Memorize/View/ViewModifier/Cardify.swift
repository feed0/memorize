//
//  Cardify.swift
//  Memorize
//
//  Created by Felipe Campelo on 20/07/25.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    let isDebugTextEnabled: Bool
    let id: String
    var isMatched: Bool

    func body(content: Content) -> some View {
        
        VStack {
            
            /// Face and Back
            ZStack {
                
                let base = RoundedRectangle(cornerRadius: Constants.Cardify.cornerRadius)
                
                /// Face
                base.strokeBorder(lineWidth: Constants.Cardify.lineWidth)
                    .background(base.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp
                             ? Constants.Opacity.show
                             : Constants.Opacity.hide)
                                
                /// Back
                base.fill()
                    .opacity(isFaceUp
                             ? Constants.Opacity.hide
                             : Constants.Opacity.show)
            }
            /// Matched
            .opacity(isMatched
                     ? Constants.Opacity.hide
                     : Constants.Opacity.show)
            .background()
            
            /// Card debug identifier
            if isDebugTextEnabled {
                Text(id)
                    .background()
            }
            
        }
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
        modifier(Cardify(isFaceUp: isFaceUp,
                         isDebugTextEnabled: isDebugTextEnabled,
                         id: id,
                         isMatched: isMatched))
    }
}
