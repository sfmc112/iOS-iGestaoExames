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
    @IBOutlet weak var pickerExameN: UIDatePicker!
    @IBOutlet weak var pickerExameR: UIDatePicker!
    @IBOutlet weak var pickerExameE: UIDatePicker!
    
    var tableView : TableViewController?
    var delegate : RefreshTableView?
    var ucSelecionada : UnidadeCurricular?
    
    var pickerASData: [[String]] = [[String]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ligar os dados
        pickerAnoSem.delegate = self
        pickerAnoSem.dataSource = self
        
        // Dados
        pickerASData = [["1º", "2º", "3º"], ["1º", "2º"]]
        
        tableView =
        
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
//        if component == 0 {
//            return pickerASData[0].count
//        }
//
//        else {
//            return pickerASData[1].count
//        }
        return pickerASData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerASData[component][row]
    }
    
    var ano = 1;
    var semestre = 1;
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var anoString = ""
        var semestreString = ""
        
        if component == 0 {
           anoString = pickerASData[component][row]
            ano = Int(String(anoString.prefix(1)))!
        } else {
            semestreString = pickerASData[component][row]
            semestre = Int(String(semestreString.prefix(1)))!
        }
        
        print("\(ano)º ano")
        print("\(semestre)º semestre")
    }
    
    @IBAction func onSave(_ sender: Any) {
        let nome = tfNome.text!
        
        if nome.count < 1 {
            tfNome.becomeFirstResponder()
            return
        }
        
        if let uc = ucSelecionada {
            // Editar UC
            uc.nome = nome
            // TODO finish this
        }else{
            // Criar UC
            let dataENormal = pickerExameN.date
            let dataERecurso = pickerExameR.date
            let dataEEspecial = pickerExameE.date
            
            let uc = UnidadeCurricular(nome: nome, ano: ano, semestre: semestre, dExameNormal: dataENormal, dExameRecurso: dataERecurso, dExameEspecial: dataEEspecial)
            
            
                
                delegate?.refresh()
            
            navigationController?.popViewController(animated: true)
            
        }
    }
}
