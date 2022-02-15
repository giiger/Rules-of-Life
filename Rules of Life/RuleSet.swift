//
//  RuleSet.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/14/20.
//

import Foundation

struct Rule {
    
    let mask: UInt8
    
    func apply(i0: Bool, i1: Bool, i2: Bool) -> Bool {
        
        var offset: UInt8 = 0
        if i0 { offset += 4 }
        if i1 { offset += 2 }
        if i2 { offset += 1 }

        return ((mask >> offset) & 0b1) == 0b1 ? true : false
    }
}

class RuleSet {
    
    var rules: [Rule] = []
    
    init() {
        
        for mask in 0..<256 {
            rules.append(Rule(mask: UInt8(mask)))
        }
    }
}
