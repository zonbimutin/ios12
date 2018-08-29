//
//  ViewController.swift
//  ImRich
//
//  Created by Felipe Alarcon on 27/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // PROPERTYS
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var imageViewRuby: UIImageView!
    
    @IBOutlet weak var labelButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // METHODS

    @IBAction func buttonPressed(_ sender: UIButton) {
    
        
         let controller = UIAlertController(title: "I am Riche", message: """
                                                                I am rich,
                                                                I deserv it,
                                                                I am good,
                                                                healthy & successful
                                                                """, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) { (UIAlertAction) in
            print("Aceptar")
        }
        
        controller.addAction(action)
        
        let action2 = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel) {
            (_) in print("Cancelar")
        }
        
        controller.addAction(action2)
        
        let action3 = UIAlertAction(title: "Borrar", style: UIAlertAction.Style.destructive, handler: {(action) in print("Borrar")
            
        })
        
        controller.addAction(action3)
        
        
        
        self.show(controller, sender: nil)
        
        //self.labelTitle.text = "He pulsado el boton"
        //self.labelTitle.textColor = UIColor.green
        //self.labelTitle.font = UIFont.systemFont(ofSize: 24.0)

        // self.imageViewRuby.image = UIImage(named: <#T##String#>)
        
    }
    
    
}

