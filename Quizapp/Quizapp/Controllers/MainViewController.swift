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
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    @IBOutlet weak var lableQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelStatusBar: UIView!
    
    // VAR
    
    
    var courrentSocer = 0
    var courrentQuestion : Int = 0
    var correctQuestions = 0
    var count = 1
    var factory : QuestionsFactory!
    var question : Question!
    
    
    // LET
    
    
/////////////////////////// INICIADOR DE CLASE////////////////////////////
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGame()
        
        

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
        
        var isCorrect : Bool!
        if sender.tag == 1 {
            isCorrect = (self.question.answer == true)
            
        }else{
            isCorrect = (self.question.answer == false)
            
        }
        
        if(isCorrect){
            self.courrentSocer += 100*count
            self.correctQuestions += 1
            self.lableQuestion.text = "Respuesta correcta"
            self.count += 1
        }else{
            self.lableQuestion.text = """
            Respuesta incorrecta
            \(question.explanation)
            """
            self.count = 1
            }
        
        hiddenButton()
        self.nextButton.isHidden = false
        
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        if  sender.tag == 1{
            
            self.selectionButton.isHidden = false
            self.negativeButton.isHidden = false
            nextQuestion()
            
            
        }else{
            startGame()
        }
    }
    
    
/////////////////////////// OWN METHODS ///////////////////////////////
    
    func startGame() {
        courrentSocer = 0
        courrentQuestion = 0
        correctQuestions = 0
        self.factory = QuestionsFactory()
        nextQuestion()
        self.labelScore.isHidden = false
        self.labelQuestionNumber.isHidden = false
        self.nextButton.isHidden = true
        self.resetButton.isHidden = true
        self.selectionButton.isHidden = false
        self.negativeButton.isHidden = false
        
        
        
    }
    
    func resetGame() {
        
    }
    
    func gameOver() {
        hiddenButton()
        self.nextButton.isHidden = true
        self.resetButton.isHidden = false
        self.labelScore.isHidden = true
        self.labelQuestionNumber.isHidden = true
        self.lableQuestion.text = """
        
        
        Juego terminado!!
        
        
        puntuacion:
        \(courrentSocer)
        
        preguntas correctas:
        \(correctQuestions)/10
        
        """
        
        
        
    }
    
    func nextQuestion() {
        
        if let newQuestion = factory.getQuestion(index: courrentQuestion){
            self.question = newQuestion
            self.lableQuestion.text = question.question
            self.labelScore.text = "Puntuacion: \(courrentSocer)"
            self.courrentQuestion += 1
            self.labelQuestionNumber.text = "\(courrentQuestion)/10"
            self.nextButton.isHidden = true
            
            for constrains in self.labelStatusBar.constraints{
               
                if constrains.identifier == "barWidth"{
                    constrains.constant = (self.view.frame.size.width/CGFloat(10))*CGFloat(self.courrentQuestion)
                }
                
            }
            
            
            
            
            
            
           
            
            
        }else{
            gameOver()
        }
        
    }
    
    func hiddenButton() {
        
        self.selectionButton.isHidden = true
        self.negativeButton.isHidden = true
        
        
    }
    
    

}
