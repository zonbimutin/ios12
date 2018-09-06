//
//  MainViewController.swift
//  Quizapp
//
//  Created by Felipe Alarcon on 06/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    
    // PROPERTYS
    
    @IBOutlet weak var lableQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelStatusBar: UIView!
    
    // VAR
    
    // LET
    
    
    
/////////////////////////// INICIADOR DE CLASE////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
/////////////////////////////////////////////////////////////////////////
    
    // manejo de los info.plist
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    
    
//////////////////////// ACTIONS METHODS ///////////////////////////////
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        print(sender.tag)
        
    }
    
    
    
/////////////////////////// OWN METHODS ///////////////////////////////
    
    
    

}
