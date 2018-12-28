//
//  DataBaseManager.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 28/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import Foundation
import UIKit

public class DatabaseManager {
    
    static func criarDisciplina(nome : String, ano : Int, semestre : Int, exameNormal : Date, exameRecurso : Date, exameEspecial : Date) {
        let disciplina = Disciplina(context: contexto)
        disciplina.nome = nome
        disciplina.ano = Int16(ano)
        disciplina.semestre = Int16(semestre)
        disciplina.dExameNormal = exameNormal
        disciplina.dExameRecurso = exameRecurso
        disciplina.dExameEspecial = exameEspecial
        
        app.saveContext()
    }
        
    static func atualizaListaDisciplinas() {
        let request = Disciplina.getDisciplinaRequest()
        
        do {
            let disciplinas = try contexto.fetch(request)
            app.lstUCs = disciplinas
            // Debug
            app.lstUCs.forEach({print($0.description)})
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
