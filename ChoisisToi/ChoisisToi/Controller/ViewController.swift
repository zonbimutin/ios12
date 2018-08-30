//
//  ViewController.swift
//  ChoisisToi
//
//  Created by Felipe Alarcon on 30/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //PROPERTYS
    
    @IBOutlet weak var answerBox: UITextView!
    
    
    //VAR
    
    var randomNumer : Int = 0
    var nMessages : UInt32
    
    
    
    //LET
    let messageInicial : String = "HAS UNA PREGUNTA Y ELEJIRE TU DESTINO!"
    
    let answers : [String]
    
    // INIT
    
    required init?(coder aDecoder: NSCoder) {
        
        answers = ["Si", "No", "Puede Ser", "Pregunta otra vez", "No tengo ni idea", "Ni lo sueñes"]
        nMessages = UInt32(answers.count)
        super.init(coder: aDecoder)
    }
    
    //INICIO
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.answerBox.text = messageInicial
        
    }
    
    //METHODS SYSTEM
    
    @IBAction func pussedButton(_ sender: UIButton) {
        
        generateRandomMessage()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        viewDidLoad()
    }
    //OWN METHODS

    func generateRandomMessage() {
        randomNumer = Int(arc4random_uniform(nMessages))
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.answerBox.transform = CGAffineTransform(scaleX: 0.5, y: 0.5).concatenating(CGAffineTransform(translationX: 0, y: -100))
            
            self.answerBox.alpha = 0.0
            
        }) { (completed) in
            // ESTADO NATURAL
            self.answerBox.transform = CGAffineTransform.identity
            
            self.answerBox.alpha = 1.0

            self.answerBox.text = self.answers[self.randomNumer]
        }
        
        
        
        
    }
    
    // SHAKING
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            generateRandomMessage()
        }
    }
}

