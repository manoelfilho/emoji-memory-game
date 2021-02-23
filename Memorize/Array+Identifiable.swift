//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Manoel Filho on 18/02/21.
//

import Foundation


//retorna o index de um elemento de um array
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
