//
//  TableViewController.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 19/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import UIKit

protocol RefreshTableView {
    func refresh()
}


class TableViewController: UITableViewController, RefreshTableView {
    
    let app = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        var items = [UIBarButtonItem]()
        
        items.append(UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(confirmaApagarTudo)))
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbarItems = items
        
        DatabaseManager.atualizaListaDisciplinas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func refresh() {
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.lstUCs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemUC", for: indexPath) as! TableViewCell

        let uc = app.lstUCs[indexPath.row]
        
        cell.nomeUC?.text = uc.nome
        cell.anoSemUC?.text = "\(uc.ano)º A / \(uc.semestre)º S"
        cell.dExameNormal?.text = uc.dExameNormal.string()
        cell.dExameRecurso?.text = uc.dExameRecurso.string()
        cell.dExamespecial?.text = uc.dExameEspecial.string()

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            DatabaseManager.eliminaDisciplina(nome: app.lstUCs[indexPath.row].nome)
            // Apagar da vista
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    var selecionada = 0
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selecionada = indexPath.row
        
        performSegue(withIdentifier: "addUC", sender: tableView)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addUC" {
            let vc = segue.destination as! NovaUCViewController
            vc.delegate = self
            if sender is UITableView {
                vc.ucSelecionada = app.lstUCs[selecionada]
            }
        }
        
    }
    
    @objc func confirmaApagarTudo() {
        let alertController = UIAlertController(title: "Eliminar tudo", message: "Tem a certeza que pretende eliminar todas as disciplinas?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Não Apagar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Apagar", style: .default, handler: {(action) -> Void in
            DatabaseManager.eliminaTodasDisciplinas()
        })
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
