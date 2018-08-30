//
//  ViewController.swift
//  DiceGame
//
//  Created by Felipe Alarcon on 30/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PROPERTYS
    
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var buttonRoll: UIButton!
    
    // VAR
    
    var randomNumberLeft : Int = 0
    var randomNumberRight : Int = 0
    
    // LET
    
    let dicesImages : [String]
    let nFaces : UInt32
    
    
    required init?(coder aDecoder: NSCoder) {
        
        dicesImages = ["D1", "D2", "D3", "D4", "D5", "D6"]
        nFaces = UInt32(dicesImages.count)
        super.init(coder: aDecoder)
        
    }
    
    //  METHODS SYSTEM
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        randomDicesGenerator()
        
    }

    // METHODS
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        randomDicesGenerator()
    
    }
    
    // OWN METHODS
    
    func randomDicesGenerator() {
        
        randomNumberLeft = Int(arc4random_uniform(nFaces))
        
        randomNumberRight = Int(arc4random_uniform(nFaces))
        
        // ANIMATION
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.imageLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: .pi/2)).concatenating(CGAffineTransform(translationX: 0, y: -50))
            self.imageRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: .pi/2)).concatenating(CGAffineTransform(translationX: 0, y: -50))
            self.imageRight.alpha = 0.0
            self.imageLeft.alpha = 0.0
            
        }) { (completed) in
            // ESTADO NATURAL
            self.imageLeft.transform = CGAffineTransform.identity
            self.imageRight.transform = CGAffineTransform.identity
            
            
            self.imageRight.alpha = 1.0
            self.imageLeft.alpha = 1.0
            
            self.imageRight.image = UIImage(named: self.dicesImages[self.randomNumberRight])
            self.imageLeft.image = UIImage(named: self.dicesImages[self.randomNumberLeft])
        }
        
    }
    
    
    
    
    
}

