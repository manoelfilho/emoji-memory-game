//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Manoel Filho on 15/02/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeMemoryGameView()
            //EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
