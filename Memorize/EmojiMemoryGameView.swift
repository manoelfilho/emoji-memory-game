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
        VStack{
            
            HStack(alignment: .lastTextBaseline) {
                
                Group{
                    EmojiItemListView(emojiGroup: viewModel.emojiGroup!)
                    Text(viewModel.emojiGroup!.name)
                        .font(.headline)
                }
                
                Spacer()
                
                Button(
                    action: {
                        withAnimation(.easeInOut){
                            self.viewModel.resetGame()
                        }
                    },
                    label: {
                        Text("Novo jogo")
                            .foregroundColor(.white)
                    }
                )
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding(6)
            
            Grid(items: viewModel.cards) { card in
                CardView(card: card)
                    .padding(3)
                    .onTapGesture {
                        withAnimation(.linear(duration:0.5)){
                            self.viewModel.choose(card: card)
                        }
                    }
            }
                .padding(3)
                .foregroundColor(Color.orange)

        }
    }
}

struct CardView: View {
    
    //MARK: - Drawing constants
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group{
                    if card.isConsumingBonusTime{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .fill(Color.gray.opacity(Double.init(0.8)))
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    }else{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .fill(Color.gray.opacity(Double.init(0.8)))
                    }
                }
                .padding(2)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                    .animation(Animation.linear(duration: 1))
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale) //só ocorre quando algo surge ou sai da tela
        }
    }
    
}
