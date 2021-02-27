//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Manoel Filho on 26/02/21.
//

import Foundation

struct EmojiGroupItem: Identifiable {
    let id = UUID()
    let principalEmoji: String
    let name: String
    let emojis: Array<String>
}
