//
//  MemoryGame.swift
//  Memorize
//
//  Created by Manoel Filho on 16/02/21.
//

import Foundation

//MODEL
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFacedUpCard: Int? {
        
        //pega somente o índice do card que que está com faceUp
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        
        //compara os índices dos cards com o valor passado para indexOfTheOneAndOnlyFacedUpCard
        //quando índice e novo valor são iguais retorna true para o faceUp do card correspondente
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        
        if let
            
            chosenIndex: Int = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                self.cards[chosenIndex].isFaceUp = true
                
            }else{
                
                indexOfTheOneAndOnlyFacedUpCard = chosenIndex
                
            }

        }
    }
    
    //    func index(of card: Card) -> Int {
    //        for index in 0..<self.cards.count {
    //            if self.cards[index].id == card.id {
    //                return index
    //            }
    //        }
    //        return 0 // TODO: bogus
    //    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
