//
//  ContentView.swift
//  Memorize
//
//  Created by Manoel Filho on 15/02/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    //sempre que ocorrer uma mudanca em ObservedObject viewModel ocorrer um redraw da view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    
    //MARK: - Drawing constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3 //edge -> borda
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size:CGSize) -> CGFloat {
        min(size.width, size.height) * self.fontScaleFactor
    }
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                Text(card.content)
            }else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
