//
//  ContentView.swift
//  Memorize
//
//  Created by Manoel Filho on 15/02/21.
//

import SwiftUI

//VIEW
struct EmojiMemoryGameView: View {
    
    //sempre que ocorrer uma mudanca em ObservedObject viewModel ocorrer um redraw da view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(items: viewModel.cards) { card in
            CardView(card: card)
                .padding(3)
                .onTapGesture {
                    self.viewModel.choose(card: card)
                }
        }
        .padding(3)
        //.foregroundColor(Color.orange)
    }
}

struct CardView: View {
    
    //MARK: - Drawing constants
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 1 //edge -> borda
    private let fontScaleFactor: CGFloat = 0.75
    
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
                RoundedRectangle(cornerRadius: self.cornerRadius).fill(Color.green)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: self.edgeLineWidth)
                
                //Circle().fill(Color.gray.opacity(Double.init(0.8))).padding(2)
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .fill(Color.gray.opacity(Double.init(0.8)))
                    .padding(2)
                
                Text(card.content)
            }else{
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: 10.0).fill()
                }
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
