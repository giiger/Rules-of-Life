//
//  Pixel.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/25/20.
//

import Foundation

struct Pixel {
    let red: CUnsignedChar
    let green: CUnsignedChar
    let blue: CUnsignedChar
    let alpha: CUnsignedChar
}

extension Pixel: Equatable {
    
}

let blackPixel = Pixel(red: 0, green: 0, blue: 0, alpha: 0xFF)
let colorPixel = Pixel(red: 255, green: 192, blue: 203, alpha: 0xFF)
