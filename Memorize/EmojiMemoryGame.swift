//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manoel Filho on 16/02/21.
//

import SwiftUI

//VIEW MODEL
class EmojiMemoryGame: ObservableObject {
    
    // Published informa ao sistema do app sempre que houver mudancas no model
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static private func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "💀", "🕷", "🕸", "🧟‍♀️", "🤠", "🙅🏿"]
        return MemoryGame<String>(numberOfPairsOfCards: 8) { (pairIndex) -> String in
            return emojis[pairIndex]
        }
    }
        
    //MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
}
