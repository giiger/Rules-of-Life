//
//  ViewController.swift
//  Rules of Life
//
//  Created by Alexander Giger on 11/8/20.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    
    @IBOutlet var lifeView: UIImageView?
    
    var generator: ImageGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let generator = self?.generator, let lifeView = self?.lifeView else {
                return
            }
            
            RulesOfLife.shared.update()
            generator.updateImage()
            lifeView.image = generator.image
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let lv = lifeView else {
            return
        }
        
        RulesOfLife.shared.set(width: Int(lv.frame.width), height: Int(lv.frame.height))
        generator = ImageGenerator(grid: RulesOfLife.shared.grid, size: lv.frame.size)
        
    }
    
    @IBAction func ruleSelect(_ sender: Any) {}
    
    @IBAction func ruleSelectDone(_ unwindSegue: UIStoryboardSegue) {
        
        guard let lv = lifeView else {
            return
        }
        
        RulesOfLife.shared.resetBuffer()
        generator = ImageGenerator(grid: RulesOfLife.shared.grid, size: lv.frame.size)
    }
}
