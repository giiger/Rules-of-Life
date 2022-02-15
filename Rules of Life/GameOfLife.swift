//
//  GameOfLife.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/26/20.
//

import Foundation

class GameOfLife {
    
    let lineBuffer1: LineBuffer
    let lineBuffer2: LineBuffer
    let lineBuffer3: LineBuffer
    
    init(lineBuffer1: LineBuffer, lineBuffer2: LineBuffer, lineBuffer3: LineBuffer) {
        self.lineBuffer1 = lineBuffer1
        self.lineBuffer2 = lineBuffer2
        self.lineBuffer3 = lineBuffer3
    }
    
    func apply() -> LineBuffer {
        
        let width = lineBuffer1.width
        let newLine = LineBuffer(width: width)
        
        if !lineBuffer1.dirty && !lineBuffer2.dirty && !lineBuffer3.dirty {
            return newLine
        }
        
        for x in 0..<width {
            let v1 = lineBuffer1.valueAt(x: x-1)
            let v2 = lineBuffer2.valueAt(x: x-1)
            let v3 = lineBuffer3.valueAt(x: x-1)
            
            let v4 = lineBuffer1.valueAt(x: x)
            let live = lineBuffer2.valueAt(x: x)
            let v5 = lineBuffer3.valueAt(x: x)
            
            let v6 = lineBuffer1.valueAt(x: x+1)
            let v7 = lineBuffer2.valueAt(x: x+1)
            let v8 = lineBuffer3.valueAt(x: x+1)
            
            var count = 0
            if v1 {
                count += 1
            }
            if v2 {
                count += 1
            }
            if v3 {
                count += 1
            }
            if v4 {
                count += 1
            }
            if v5 {
                count += 1
            }
            if v6 {
                count += 1
            }
            if v7 {
                count += 1
            }
            if v8 {
                count += 1
            }
            
            var value = blackPixel
            if live && (count == 2 || count == 3) {
                value = colorPixel
            } else if !live && count == 3 {
                value = colorPixel
            }

            newLine.set(value: value, at: x)
        }
        
        return newLine
    }
}
