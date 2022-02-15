//
//  BufferGrid.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/25/20.
//

import Foundation

class BufferGrid {
    
    let width: Int
    let height: Int
    var buffers: [LineBuffer] = []
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        for _ in 0..<height{
            buffers.append(LineBuffer(width: self.width))
        }
        
        if let buffer = buffers.last {
            buffer.set(value: colorPixel, at: width / 2)
        }

    }
    
    func removeTop() {
        
        buffers.remove(at: 0)
    }
    
    func remove(row: Int) {
        if row >= 0 && row < buffers.count {
            buffers.remove(at: row)
        }
    }
    
    func addToEnd(line: LineBuffer) {
        
        buffers.append(line)
    }
}
