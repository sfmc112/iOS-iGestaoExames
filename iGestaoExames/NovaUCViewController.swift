//
//  NovaUCViewController.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 19/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import UIKit

class NovaUCViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var pickerAnoSem: UIPickerView!
    
    var pickerASData: [[String]] = [[String]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ligar os dados
        pickerAnoSem.delegate = self
        pickerAnoSem.dataSource = self
        
        // Dados
        pickerASData = [["1º", "2º", "3º"], ["1º", "2º"]]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Picker Ano / Semestre
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerASData[0].count
        }
            
        else {
            return pickerASData[1].count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerASData[component][row]
    }
    
}
