//
//  RulesOfLife.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/14/20.
//

import Foundation

class RulesOfLife {
    
    static var shared = RulesOfLife()
    
    var rule: Rule = Rule(mask: 30)
    var grid: BufferGrid = BufferGrid(width: 100, height: 100)
    var halfHeight: Int = 50
    
    init() {
    }
    
    func resetBuffer() {
        grid = BufferGrid(width: grid.width, height: grid.height)
    }
    
    func set(width: Int, height: Int) {
        grid = BufferGrid(width: width, height: height)
        halfHeight = height/2
    }
    
    func set(rule: Rule) {
        self.rule = rule
    }
    
    func update() {
        
        updateAutomata()
        
        updateGameOfLife()
    }
    
    func updateAutomata() {
        
        grid.remove(row: halfHeight)
        
        if let lastLine = grid.buffers.last {
            let newLastLine = lastLine.apply(rule: rule)
            grid.addToEnd(line: newLastLine)
        }
    }
    
    func updateGameOfLife() {
     
        var newHalf: [LineBuffer] = []
        
        for y in 1..<halfHeight {
            let line1 = grid.buffers[y-1]
            let line2 = grid.buffers[y]
            let line3 = grid.buffers[y+1]
            
            let game = GameOfLife(lineBuffer1: line1, lineBuffer2: line2, lineBuffer3: line3)
            let newLine = game.apply()
            newHalf.append(newLine)
        }
        
        for _ in 1..<halfHeight {
            grid.buffers.remove(at: 1)
        }
        
        grid.buffers.insert(contentsOf: newHalf, at: 1)
    }
}
