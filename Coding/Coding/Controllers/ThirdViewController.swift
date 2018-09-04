//
//  ThirthViewController.swift
//  Coding
//
//  Created by Felipe Alarcon on 30/08/2018.
//  Copyright © 2018 Felipe Alarcon. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    
    // PROPERTYS
    @IBOutlet weak var tableView: UITableView!
    
    // VAR
    
    var fonts : [String:[String]] = [:]
    // LET
    
    let familys : [String]
    
    // INIT
    
    required init?(coder aDecoder: NSCoder) {
        
        self.familys = UIFont.familyNames.sorted(by: { return $0 < $1 })
        
        
        super.init(coder: aDecoder)
    }
    
    // SYSTEM
    override func viewDidLoad() {
        super.viewDidLoad()

        getFonts()
        
    }
    
    // METHODS SYS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFontsForFamily"{
            
            let navController = segue.destination as! UINavigationController
            // constructor
            let destinationVC = navController.topViewController as! FontDetailViewController
            
            // identificador
            let idx = self.tableView.indexPathForSelectedRow!.row
            
            destinationVC.familyName = self.familys[idx]
            destinationVC.fonts = self.fonts[self.familys[idx]]!
            destinationVC.fonts.append("")
            destinationVC.fonts = destinationVC.fonts.sorted(by: {return $0<$1})
            
        }
    }
    
    
    
    // MARK: Metdos de la clase UITable
    
      // prepara una seccion
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
      // cuantas filas va tener la seccion
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.familys.count
    }
    // configurar cada celda que tiene seccion y fila(row)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontFamilyCell", for: indexPath)
        let fontFamily = familys[indexPath.row]
        
        // nombre y forma de la familia
        cell.textLabel?.text = fontFamily
        cell.textLabel?.font = UIFont(name: fontFamily, size: 17.0)
        return cell
    }
    
    // MARK: Metodos del protocolo UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let fontFamily = familys[row]
        let familyFonts = fonts[fontFamily]! // se utiliza el ! para expresar que todos los datos existen
        print(familyFonts)
    }
    
    
    
    
    // OWN METHODS

    func getFonts() {
        
        for fam in familys{
            fonts[fam] = UIFont.fontNames(forFamilyName: fam)
        }
        

    }
    
}
