//
//  ViewController.swift
//  RicheOuPauvre
//
//  Created by Felipe Alarcon on 29/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PROPRETYS
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var imageSelected: UIImageView!
    
    @IBOutlet weak var rigthButtomLabel: UIButton!
    
    @IBOutlet weak var leftButtomLabel: UIButton!
    
    @IBOutlet weak var infoButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // METHODS
    
    @IBAction func rigthButtom(_ sender: UIButton) {
        
        self.imageSelected.image = UIImage(named:"violin-35026" )
        self.imageSelected.accessibilityIdentifier = "Pauvre"
        
    }
    
    @IBAction func leftButtom(_ sender: UIButton) {
        
        self.imageSelected.image = UIImage(named:"man-160928" )
        self.imageSelected.accessibilityIdentifier = "Riche"
        
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        
        var riche = """
                                                                I am rich,
                                                                I deserv it,
                                                                I am good,
                                                                healthy & successful
                                                                """
        var pauvre = """
                                                                I am pauvre,
                                                                I deserv it,
                                                                I am good,
                                                                healthy & successful
                                                                """
        var message = ""
        
        if self.imageSelected.accessibilityIdentifier == "Riche" {
            message = riche
        }
        if self.imageSelected.accessibilityIdentifier == "Pauvre" {
            message = pauvre
        }
        
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        
        controller.addAction(action)
        self.show(controller, sender: nil)
    }


}
