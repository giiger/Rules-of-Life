//
//  ImageGenerator.swift
//  RulesOfLife
//
//  Created by Matthew Giger on 11/8/20.
//  Copyright © 2020 Matthew Giger. All rights reserved.
//

import UIKit
import CoreGraphics

class ImageGenerator {
	
	let grid: BufferGrid
	var imageData: UnsafeMutablePointer<Pixel>
    let size: CGSize
	
    init(grid: BufferGrid, size: CGSize) {
		self.grid = grid
        self.size = size
        
		imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: Int(size.width * size.height))

        let bytesPerRow = Int(size.width) * MemoryLayout<Pixel>.size
        memset(imageData, 0, Int(size.height) * bytesPerRow)
	}
    
	func updateImage() {
		
        var rowOffset: Int = 0
        let pixelsPerRow = Int(size.width)
        let bytesPerRow = Int(size.width) * MemoryLayout<Pixel>.size
        
        for buffer in grid.buffers {
            buffer.pixels.withUnsafeBufferPointer { result in
                memcpy(imageData + rowOffset, result.baseAddress, bytesPerRow)
            }
            rowOffset += pixelsPerRow
        }
	}
	
	var image: UIImage? {
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
		bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
		let bytesPerRow = Int(size.width) * MemoryLayout<Pixel>.size
		
		guard let imageContext = CGContext(
			data: imageData,
			width: Int(size.width),
			height: Int(size.height),
			bitsPerComponent: 8,
			bytesPerRow: bytesPerRow,
			space: colorSpace,
			bitmapInfo: bitmapInfo
		) else { return nil }
		
		guard let newCGImage = imageContext.makeImage() else {
			return nil
		}
		return UIImage(cgImage: newCGImage)
	}
}
