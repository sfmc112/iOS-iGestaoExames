//
//  NovaUCViewController.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 19/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import UIKit
import CoreData

class NovaUCViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var pickerAnoSem: UIPickerView!
    @IBOutlet weak var pickerExameN: UIDatePicker!
    @IBOutlet weak var pickerExameR: UIDatePicker!
    @IBOutlet weak var pickerExameE: UIDatePicker!
    
    var delegate : RefreshTableView?
    var ucSelecionada : Disciplina?
    
    var pickerASData: [[String]] = [[String]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ligar os dados
        pickerAnoSem.delegate = self
        pickerAnoSem.dataSource = self
        
        // Dados
        pickerASData = [["1º", "2º", "3º"], ["1º", "2º"]]
        
        // Do any additional setup after loading the view.
        
        var canEdit = true
        
        if let uc = ucSelecionada {
            // TODO alertcontroller Sim/Não para perguntar se quer editar o nome
            canEdit = false
            tfNome.text = uc.nome
            pickerAnoSem.selectRow(Int(uc.ano) - 1, inComponent: 0, animated: false)
            pickerAnoSem.selectRow(Int(uc.semestre) - 1, inComponent: 1, animated: false)
            pickerExameN.setDate(uc.dExameNormal, animated: false)
            pickerExameR.setDate(uc.dExameRecurso, animated: false)
            pickerExameE.setDate(uc.dExameEspecial, animated: false)
        }
        
        tfNome.isUserInteractionEnabled = canEdit
        pickerAnoSem.isUserInteractionEnabled = canEdit
        tfNome.becomeFirstResponder()
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
        
        // print("\(ano)º ano")
        // print("\(semestre)º semestre")
    }
    
    @IBAction func onSave(_ sender: Any) {
        let nome = tfNome.text!
        
        if nome.count < 1 {
            tfNome.becomeFirstResponder()
            return
        }
        
        let dataENormal = pickerExameN.date
        let dataERecurso = pickerExameR.date
        let dataEEspecial = pickerExameE.date
        
        if let uc = ucSelecionada {
            // Editar UC
            uc.editaDisciplina(nome: nome, ano: ano, semestre: semestre, exameNormal: dataENormal, exameRecurso: dataERecurso, exameEspecial: dataEEspecial)
        }else{
            // Criar UC
            DatabaseManager.criarDisciplina(nome: nome, ano: ano, semestre: semestre, exameNormal: dataENormal, exameRecurso: dataERecurso, exameEspecial: dataEEspecial)
        }
        
        delegate?.refresh()
        
        navigationController?.popViewController(animated: true)
    }
    
}
