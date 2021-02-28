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
    private(set) var scoreGame: Int = 0
    
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
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
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
                    
                    if cards[potentialMatchIndex].bonusTimeRemaining > 0.0 {
                        
                        cards[chosenIndex].hasBonus = true
                        cards[potentialMatchIndex].hasBonus = true
                        
                        self.scoreGame += 2*Int(cards[potentialMatchIndex].bonusTimeRemaining)
                    }
                        
                }else{
                    
                    self.scoreGame -= 2
                
                }
                
                self.cards[chosenIndex].isFaceUp = true
                
            }else{
                
                indexOfTheOneAndOnlyFacedUpCard = chosenIndex
                
            }

        }
    }
    
    struct Card: Identifiable {
        
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
                return pastFaceUpTime
            }
        }
        
        var hasBonus: Bool = false
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        
        var bonusTimeLimit: TimeInterval = 6
        
        var pastFaceUpTime: TimeInterval = 0
        
        var lastFaceUpDate: Date?
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
        var id: Int
    }
    
}
