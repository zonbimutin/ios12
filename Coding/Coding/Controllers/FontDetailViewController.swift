//
//  FontDetailViewController.swift
//  Coding
//
//  Created by Felipe Alarcon on 03/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class FontDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    // PROPERTYS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var pikerFontsLabel: UIPickerView!
    
    // VAR
    
    var familyName : String = ""
    var fonts : [String] = []
    var sizeFont : Double = 17.0
    var font : String = ""
    
    // LET
   
    // INIT
    

    
    // SYSTEM
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
        
        self.titleLabel.text = familyName
        self.titleLabel.font = UIFont(name: familyName, size: 25.0)
        
        

        if fonts.count == 0{
            self.pikerFontsLabel.isHidden = true
        }
        // Do any additional setup after loading the view.
        
        self.pikerFontsLabel.dataSource = self
        self.pikerFontsLabel.delegate = self
        
    }
    
    // METHODS SYSTEM
    
        // MARK: NavigationBar
    
    @IBAction func returnButton(_ sender: UIBarButtonItem) {
        // Cerrar viewController
        self.dismiss(animated: true, completion: nil)
    }
    
    
        // MARK: Stepper
    @IBAction func sizeStepper(_ sender: UIStepper) {
        self.sizeFont = sender.value
        updateLabels()
    }
    
        // MARK: Piker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.font = fonts[row]
        updateLabels()
    }
    
    
    // OWN METHODS
    
    func updateLabels() {
        
        self.sizeLabel.text = String(sizeFont)
        if font == ""{
            self.textLabel.font = UIFont(name: familyName, size: CGFloat(sizeFont))
        }else{
            self.textLabel.font = UIFont(name: font, size: CGFloat(sizeFont))
        }
        
        
    }
    

}
