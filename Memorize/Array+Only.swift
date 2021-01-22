//
//  Array+Only.swift
//  Memorize
//
//  Created by JJONAMI on 2021/01/22.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
