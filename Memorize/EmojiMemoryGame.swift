//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Manoel Filho on 16/02/21.
//

import SwiftUI

//VIEW MODEL
class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>?
    
    var emojiGroup: EmojiGroup?
    
    init(with group: EmojiGroup) {

        self.emojiGroup = group
        self.createMemoryGame()
    }
    
    func createMemoryGame(){
        self.model = MemoryGame<String>(numberOfPairsOfCards: 14) { (pairIndex) -> String in
            if let emojis = self.emojiGroup {
                return emojis.emojis[pairIndex]
            }else{
                return ""
            }
        }
    }
        
    //MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card>{
        return model!.cards
    }
    
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model!.choose(card: card)
    }
    
    func resetGame(){
        self.createMemoryGame()
    }
    
}
