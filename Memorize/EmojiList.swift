//
//  EmojiList.swift
//  Memorize
//
//  Created by Manoel Filho on 26/02/21.
//

import Foundation

struct EmojiList {
    static let emojiList: [EmojiGroup] = [
        
        EmojiGroup(
            main: "🦁",
            name: "Animais",
            emojis: [
                "🐇","🦔","🐖","🐤","🐬","🐞","🐢","🦈","🐊","🐳","🐯","🦊","🐷","🐰"
            ]
        ),
        
        EmojiGroup(
            main: "🇧🇷",
            name: "Bandeiras",
            emojis: [
                "🇲🇱","🇳🇵","🇲🇷","🇲🇭","🇱🇷","🇸🇬","🇻🇺","🇵🇹","🇸🇷","🇸🇪","🇰🇷","🇱🇹","🇫🇯","🇧🇷"
            ]
        ),
        
        EmojiGroup(
            main: "🍰",
            name: "Doces",
            emojis: [
                "🍭","🎂","🍰","🍬","🍫","🍪","🍮","🍩","🍯","🍨","🍧","🍦","🥧","🧁"
            ]
        )
        
    ]
}
