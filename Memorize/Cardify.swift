//
//  Cardify.swift
//  Memorize
//
//  Created by Manoel Filho on 24/02/21.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 1 //edge -> borda
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.green)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                content
            }else{
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
