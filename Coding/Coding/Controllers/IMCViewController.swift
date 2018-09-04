//
//  IMCViewController.swift
//  Coding
//
//  Created by Felipe Alarcon on 03/09/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class IMCViewController: UIViewController {

    
    // PROPERTYS
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var estaturaLabel: UILabel!
    @IBOutlet weak var imcLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var conceilText: UITextView!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    // VAR
    
    var estatura : Int = 0 // cm
    var peso : Int = 0 // Kg
    var imc : Double = 0.0 // Kg/m2
    var nombre = ""
    var apellido = ""
    var age = ""
    
    
    
    // LET
    
    let sobrepeso : [String] = ["Sobrepeso",
                                """
La recomendación es hacer 420 minutos de actividad física moderada a vigorosa por semana (esto es, 1 hora diaria) para niños y adolescentes, y por lo menos 3 días a la semana de actividad física de intensidad vigorosa. Actividad física moderada es aquella que acelera de forma perceptible el ritmo cardíaco, por ejemplo caminar a paso rápido, bailar, cortar el pasto, realizar tareas domésticas y/o participar en juegos y deportes con niños o mascotas. En tanto, la actividad física vigorosa es la que requiere una gran cantidad de esfuerzo y provoca una respiración rápida y un aumento sustancial de la frecuencia cardíaca.
"""]
    let desnutricion : [String] = ["Bajo de peso",
                                """
 procurar que vuestro régimen alimenticio incluya hidratos de carbono, proteínas, grasa o lípidos, vitaminas y minerales en forma balanceada. Podemos complementar nuestra dieta con suplementos vitamínicos y alimenticios. Es fundamental que estas medidas se fortalezcan y vigilen estrechamente durante el embarazo, la lactancia, la  infancia, la adolescencia y la vejez.
"""]
    let normal : [String] = ["Peso Estable",
                                   """
 La mejor forma de mantenerse en un peso saludable (o de perder peso en caso necesario) es hacer elecciones saludables en lo que a alimentos se refiere cada día. Para algunos, esto implicará modificar la mentalidad en lo que a la comida se refiere. En vez de pensar en la comida en términos emocionales (por ejemplo, como una recompensa por haber sacado buena nota en un examen o una forma de afrontar el estrés), vela tal y como es
"""]
    
    
    // SYSTEM
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ageLabel.text = age
        self.lastNameLabel.text = apellido
        self.nameLabel.text = nombre
        self.ageLabel.text = age
        self.estaturaLabel.text = String(estatura)
        self.pesoLabel.text = String(peso)

        // Do any additional setup after loading the view.
        
        generateIMC()
        
       
        
    }
    
    // METHODS SYSTEM
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // OWN METHODS
    
    func generateIMC() {
        
        self.imc = Double(peso)/Double(((estatura/100)^2))
        imc = imc.rounded(FloatingPointRoundingRule.toNearestOrEven)
        self.imcLabel.text = String(imc)
        
        pesoStatus()
        
        
    }
    
    func pesoStatus() {
        if imc < 18.5 {
            self.conceilText.text = desnutricion[1]
            self.statusLabel.text = desnutricion[0]
            self.imageLabel.image = UIImage(named: "local-3184036_1920")
        }
        if imc > 18.5 && imc < 22.5 {
            self.conceilText.text = normal[1]
            self.statusLabel.text = normal[0]
            self.imageLabel.image = UIImage(named: "check-mark-29114_1280")
        }
        if imc > 22.5 {
            self.conceilText.text = sobrepeso[1]
            self.statusLabel.text = sobrepeso[0]
            self.imageLabel.image = UIImage(named: "police-man-306848_1280")
        }
    }
    
    

}
