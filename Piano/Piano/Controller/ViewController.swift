//
//  ViewController.swift
//  Piano
//
//  Created by Felipe Alarcon on 04/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    
    var vol = 0.0
    
    
    let soundArray = ["c1", "c1s","d1", "d1s", "e1", "f1", "f1s", "g1", "g1s", "a1", "a1s", "b1", "c2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // SEGUE


    // METHODS SYS
    
    
    @IBAction func playSound(_ sender: UIButton) {
        let idTag = sender.tag
        let fileName = soundArray[idTag-1]
        
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            }catch{
                print(error)
            }
            audioPlayer.play()
            print(vol)
        }
        
        
        
        
    }
    

}

