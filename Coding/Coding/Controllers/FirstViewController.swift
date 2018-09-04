//
//  FirstViewController.swift
//  Coding
//
//  Created by Felipe Alarcon on 30/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    // PROPERTYS
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var slideAgeBarLabel: UISlider!
    
    
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var pesoSliderLabel: UISlider!
    
    @IBOutlet weak var estaturaSliderLabel: UISlider!
    @IBOutlet weak var estaturaLabal: UILabel!
    
    // LET
    
    // VAR
    var ageUser : Int = 0
    var nameUser : String = ""
    var lastNameUser : String = ""
    var messageTextFilde = "Debe llenar el campo del nombre y apellido"
    var peso : Int = 0
    var estatura : Int = 0
    
    
    
    // Init
    
    
    
    // SYSTEM FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateLabels()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastNameTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowIMC"{
            let navController = segue.destination as! UINavigationController
            let destinationVC = navController.topViewController as! IMCViewController
            if nameTextField.text == "" && lastNameTextField.text == ""{
                alertMessage(messageTextFilde)
                return
            }
            destinationVC.estatura = Int(self.estaturaLabal.text!)!
            destinationVC.peso = Int(self.pesoLabel.text!)!
            destinationVC.nombre = self.nameTextField.text!
            destinationVC.apellido = self.lastNameTextField.text!
            destinationVC.age = String(self.ageUser)
            
        }
        
        
    }

    // METHODS SYSTEM
    
    // Button
    @IBAction func saveButton(_ sender: Any) {
        
        
        
    }
    
    
     // SlidereBar
    @IBAction func sliderAgeMoved(_ sender: UISlider) {
        
        updateLabels()
        
    }

    
    @IBAction func pesoSlider(_ sender: UISlider) {
        
        updateLabels()
        
    }
    
    
    @IBAction func estaturaSlider(_ sender: UISlider) {
        
        updateLabels()
    }
    
    
    // ReturnButton
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField{
            lastNameTextField.becomeFirstResponder()// cambia de textFiled
        }
        if textField == lastNameTextField{
            lastNameTextField.resignFirstResponder()// cierra el keyboard
        }
        
        return true
    }
    
    
    
    // OWN METHODS
    
    func updateLabels() {
        
        self.ageUser = Int(self.slideAgeBarLabel.value)
        self.ageLabel.text = String(ageUser)
        
        self.peso = Int(self.pesoSliderLabel.value)
        self.pesoLabel.text = String(self.peso)
        
        self.estatura = Int(self.estaturaSliderLabel.value)
        self.estaturaLabal.text = String(estatura)
    }
    
    func alertMessage(_ message : String){
        
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)

        controller.addAction(action)
        self.show(controller, sender: nil)
    }

}

