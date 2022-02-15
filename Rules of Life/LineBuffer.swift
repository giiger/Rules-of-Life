//
//  LineBuffer.swift
//  RulesOfLife
//
//  Created by Matthew Giger on 11/8/20.
//  Copyright © 2020 Matthew Giger. All rights reserved.
//

import Foundation

class LineBuffer {
    
    var dirty: Bool = false
	let width: Int
	private var data: [Pixel]
	
	init(width: Int) {
		self.width = width
		data = [Pixel](repeating: blackPixel, count: width)
	}
    
    func set(value: Pixel, at index: Int) {
        if value != blackPixel {
            dirty = true
        }
        data[index] = value
    }
    
    func valueAt(x: Int) -> Bool {
        if !dirty {
            return false
        }
        if x < 0 {
            return data[width-1] == blackPixel ? false : true
        } else if x >= width {
            return data[0] == blackPixel ? false : true
        } else {
            return data[x] == blackPixel ? false : true
        }
    }
    
    var pixels: [Pixel] {
        return data
    }

	
    func apply(rule: Rule) -> LineBuffer {
        
        var isDirty = false
        let newLine = LineBuffer(width: width)
        for x in 0..<width {
            let index = data.index(data.startIndex, offsetBy: x)
            
            let i0 = valueAt(x: x-1)
            let i1 = valueAt(x: x)
            let i2 = valueAt(x: x+1)
            let val: Bool = rule.apply(i0: i0, i1: i1, i2: i2)
            isDirty = val || isDirty
            newLine.data[index] = val ? colorPixel : blackPixel
        }
        
        newLine.dirty = isDirty
        return newLine
	}
}
