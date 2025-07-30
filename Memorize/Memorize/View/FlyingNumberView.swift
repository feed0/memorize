//
//  FlyingNumberView.swift
//  Memorize
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 29/07/25.
//

import SwiftUI

struct FlyingNumberView: View {
    
    let  number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumberView(number: 5)
}
