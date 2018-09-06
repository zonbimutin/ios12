//
//  PianoViewController.swift
//  MusicalInstruments
//
//  Created by Felipe Alarcon on 05/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit
import AVFoundation

class PianoViewController: UIViewController {
    
    //PROPERTYS
    
    
    @IBOutlet weak var volLabel: UISlider!
    
    //VAR
    var audioPlayer : AVAudioPlayer!
    var volume : Float = 1.0
    
    
    //LET
    let soundArray = ["c1", "c1s","d1", "d1s", "e1", "f1", "f1s", "g1", "g1s", "a1", "a1s", "b1", "c2"]
    
    ////////SYSTEM

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    //// SEGUE
    
    
    
    /////// METHODS
    //@IBAction func doneButton(_ sender: UIBarButtonItem) {
        //self.dismiss(animated: true, completion: nil)
    //}
    
    
    @IBAction func sliderVolume(_ sender: UISlider) {
        
        volume = volLabel.value
        print(volume)
    }
    
    
    @IBAction func pianoButton(_ sender: UIButton) {
        
        let idTag = sender.tag
        let fileName = soundArray[idTag-1]
        
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            }catch{
                print(error)
            }
            audioPlayer.isMeteringEnabled = true
            audioPlayer.volume = volume
            audioPlayer.play()
            
            print(audioPlayer.volume)
            //audioPlayer.updateMeters()
            
            //print(audioPlayer.averagePower(forChannel: 0))
            //print(audioPlayer.settings)
            
            
        }
        
        
        
    }
    
    
    
    ////// OWN METHODS
    

}
