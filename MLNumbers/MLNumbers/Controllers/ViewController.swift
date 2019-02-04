//
//  ViewController.swift
//  MLNumbers
//
//  Created by Felipe Alarcon on 12/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drawingView: DrawingImageView!
    @IBOutlet weak var timeProgress: UIProgressView!
    
    
    var mnistModel = MnistModel()
    let factory = QuestionFactory()
    
    var gameTimer = Timer()
    
    var totalTime = 60
    
    var timeLeft: Int = 0
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawingView.delegate = self
        
        title = "Math Trainer"
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1
        
        timeLeft = totalTime
        
        self.timeProgress.progress = 1.0
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeLeft -= 1
            self.timeProgress.progress = Float(max(self.timeLeft, 0)) / Float(self.totalTime)
            
        })
        
    }
    
    
    //    MARK: UITableViewDelegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factory.getNumberOfQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTable", for: indexPath)
        if let courrentQuestion = factory.getQuestion(indexPath.row){
            setText(for: cell, at: indexPath, to: courrentQuestion)
        }
        return cell
    }
    //    MARK: UITableDelegate Methods
    
//    altura de la celda entrante
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
//    altura de las celdas en pantalla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
    
    
    
    
    
    
    //    MARK: Own Methods
    
    func numberDrawn(_ image: UIImage) {
        
//        1. Redimensionar la imagen del usuario a 299 x 299
        let modelSize = 299
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: modelSize, height: modelSize), true, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: modelSize, height: modelSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
//        2. UIImage -> CIImage
        
        guard let ciImage = CIImage(image: newImage) else {
            fatalError("Error al convertir de UIImage a CIImage")
        }
        
//        3. Cargar el modelo en vision
        guard let model = try? VNCoreMLModel(for: mnistModel.model) else{
            fatalError("No se a podido preparar el modelo para VNCorel")
        }
        
//        4. Peticion VNCoreMLRequest
        let request = VNCoreMLRequest(model: model) { [weak self](request, error) in
        
//          5. Al detectar la imagen, tenemos que saber el numero que a escrito el usuario y validar la respuesta
            guard let results = request.results as? [VNClassificationObservation], let prediction = results.first else{
                fatalError("Error al hacer la prediccion: \(error?.localizedDescription ?? "Error desconocido")")
            }
            DispatchQueue.main.async {
//                El resultado es la etiqueta de la clase donde el modelo ha catalogado la imagen
                let result = Int(prediction.identifier) ?? 0
//                asignamos la respuesta del usuario a la pregunta actual
                self?.factory.updateQuestion(at: 0, with: result)
//                actualizar la celda
                self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//                validamos si la respuesta es correcta
                self?.factory.validateQuestion(at: 0)
//                creamos una nueva pregunta
                self?.askNextQuestion()
            }
            
            
        }
        
//        6. Juntar todo en un VNImageRequestHandler
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
//        ejecutamos la prediccion en un hilo secundario
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try handler.perform([request])
            }catch{
                print(error.localizedDescription)
            }
        }
    
    }
    
    func askNextQuestion() {
        self.drawingView.image = nil
        
        if(timeLeft > 0){
            
            factory.addNewQuestion()
            
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.right)
            
            let secondIndexPath = IndexPath(row: 1, section: 0)
            if let cell = tableView.cellForRow(at: secondIndexPath){
                setText(for: cell, at: secondIndexPath, to: factory.getQuestion(1)!)
            }
        }else{
            
            gameTimer.invalidate()
            

            let controller = UIAlertController(title: "Fin del juego", message: "Has consegido: \(self.factory.score) puntos / ", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Jugar de nuevo", style: .default, handler: restartGame)
            controller.addAction(action)
            present(controller, animated: true)
        }
        
    }
    
    func setText(for cell: UITableViewCell, at indexPath: IndexPath, to question: Question) {
        if indexPath.row == 0{
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        }else{
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            if question.answer == question.userAnswer {
                cell.backgroundColor = UIColor.green
            }else{
                cell.backgroundColor = UIColor.red
            }
        }
        if let userAnswer = question.userAnswer{
            cell.textLabel?.text = "\(question.text) = \(userAnswer)"
        }else{
            cell.textLabel?.text = "\(question.text) = ?"
        }
    }
    
    func restartGame(action: UIAlertAction) {
        factory.resetData()
        self.tableView.reloadData()
        
        timeLeft = totalTime
        
        self.timeProgress.progress = 1.0
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timeLeft -= 1
            self.timeProgress.progress = Float(max(self.timeLeft, 0)) / Float(self.totalTime)
        })
    }
}

