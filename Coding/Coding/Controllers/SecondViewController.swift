//
//  SecondViewController.swift
//  Coding
//
//  Created by Felipe Alarcon on 30/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit



class SecondViewController: UIViewController {
    
    // PROPERTYS
    @IBOutlet weak var fibIdLabel: UILabel!
    @IBOutlet weak var fibIdSliderLabel: UISlider!
    @IBOutlet weak var fibNumText: UITextView!
    @IBOutlet weak var fibNumLabel: UITextView!
    @IBOutlet weak var switchLabel: UILabel!
    
    
    // LET
    
    let messageOutOfRange : String = """
    El rango debe
    estar entre
    1 y 70
    """
    
    
    // VAR
    
    var fibonacci : [Int] = [0,1]
    var fibId : Int = 1
    var goldNumber : Double = 0.0
    var watsGoldNumber = false
    
    
    
    
    
    // SYSTEM FUNC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateFibLabels()
        
    }

    // METHODS SYSTEM
    
    @IBAction func fibIdSlider(_ sender: UISlider) {
        
        fibId = Int(fibIdSliderLabel.value)
        fibGenerator()
        updateFibLabels()
        goldNumberGenerator()
        
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        
        self.watsGoldNumber = sender.isOn
        updateFibLabels()
        
    }
    
    
    // OWN METHODS
    
    
    
    func updateFibLabels() {
        
        self.fibId = Int(self.fibIdSliderLabel.value)
        self.fibIdLabel.text = String(fibId)
        self.fibNumLabel.text = String(fibonacci[fibId])
        goldNumberGenerator()
        
    }
    
    func fibGenerator() {
        
        if fibId >= fibonacci.count {
            for i in fibonacci.count...fibId {
                fibonacci.append(fibonacci[i-1]+fibonacci[i-2])
                print(i, fibonacci[i])
            }
        }
        let fibStr : [String] = fibonacci.compactMap({String($0)})
        let result : String = fibStr.joined(separator: "\n")
        self.fibNumText.text = result
        
    }
    
    func alertMessage(_ message : String){
        
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        controller.addAction(action)
        self.show(controller, sender: nil)
    }
    
    func goldNumberGenerator() {
        
        
        if watsGoldNumber{
            
            let last = Double(fibonacci[fibId])
            let previous = Double(fibonacci[fibId-1])
            self.goldNumber = last/previous
            self.switchLabel.text = String(goldNumber)
            
        }else{
            self.switchLabel.text = "Ver el numero de oro"
        }
    }
    
}

