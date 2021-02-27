//
//  ThemeMemoryGameView.swift
//  Memorize
//
//  Created by Manoel Filho on 26/02/21.
//

import SwiftUI

struct ThemeMemoryGameView: View {
    var body: some View {
        NavigationView {
            List(EmojiList.emojiList) { emojiGroup in
                
                NavigationLink(destination: EmojiMemoryGameView( viewModel: EmojiMemoryGame(with: emojiGroup) ) ) {
                    HStack {
                        EmojiItemListView(emojiGroup: emojiGroup)
                        Text(emojiGroup.name)
                        .font(.headline)
                    }.padding(1)
                }
            }
            .navigationBarTitle("Emoji Game")
        }
    }
}

struct ThemeMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeMemoryGameView()
    }
}

struct EmojiItemListView: View {
    
  let emojiGroup: EmojiGroup
  
  var body: some View {
    ZStack {
      Text(emojiGroup.main)
        .shadow(radius: 3)
        .font(.largeTitle)
        .frame(width: 65, height: 65)
        .overlay(
          Circle().stroke(Color.green, lineWidth: 1)
        )
    }
  }
}

struct EmojiGroup: Identifiable {
    let id = UUID()
    let main: String
    let name: String
    let emojis: Array<String>
}
