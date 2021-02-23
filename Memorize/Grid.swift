//
//  Grid.swift
//  Memorize
//
//  Created by Manoel Filho on 18/02/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout:GridLayout) -> some View {
        ForEach(self.items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    //replaced by extension Array where Element: Identifiable
    
    //    func index(of item: Item) -> Int {
    //        for index in 0..<items.count{
    //            if items[index].id == item.id {
    //                return index
    //            }
    //        }
    //        return 0 // TODO: bogus
    //    }
    
    /*
        tanto o elemento Item que será representado pelo modelo do card
        quanto o ItemView que será representado pela view do card (CardView)
        são desconhecidos dessa struct, portanto:
     
        1 - Para permitir que esse elemento seja percorrido no Foreach ele precisa ser Identifiable
        2 - ItemView aqui será representado po um CardView e nesse caso ele precisa ser do tio View
        
        A solução para os dois é definir seus tipos (Seus protocolos) na assinatura da Struct acima:
        ->   where Item: Identifiable, ItemView: View
     */
}
