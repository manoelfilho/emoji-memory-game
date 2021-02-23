//
//  Array+Only.swift
//  Memorize
//
//  Created by Manoel Filho on 21/02/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
