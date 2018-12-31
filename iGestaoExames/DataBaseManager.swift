//
//  DataBaseManager.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 28/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import Foundation
import UIKit


protocol OrdenarDisciplinas {
    static func ordenaPorNome()
    static func ordenaPorPlanoCurricular()
    static func ordenaPorDataDoExame()
}

public class DatabaseManager : OrdenarDisciplinas {
    
    static func ordenaPorNome() {
        let request = Disciplina.getDisciplinaRequest()
        let sort = NSSortDescriptor(key: "nome", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            let disciplinas = try contexto.fetch(request)
            app.lstUCs = disciplinas
            // Debug
            app.lstUCs.forEach({print($0.description)})
            app.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func ordenaPorPlanoCurricular() {
        let request = Disciplina.getDisciplinaRequest()
        let sortAno = NSSortDescriptor(key: "ano", ascending: true)
        let sortSemestre = NSSortDescriptor(key: "semestre", ascending: true)
        request.sortDescriptors = [sortAno, sortSemestre]
        
        do {
            let disciplinas = try contexto.fetch(request)
            app.lstUCs = disciplinas
            // Debug
            app.lstUCs.forEach({print($0.description)})
            app.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func ordenaPorDataDoExame() {
        // Ordenar em primeiro pelo exame da época normal
        let request = Disciplina.getDisciplinaRequest()
        var sort = [NSSortDescriptor]()
        sort.append(NSSortDescriptor(key: "dExameNormal", ascending: true))
        sort.append(NSSortDescriptor(key: "dExameRecurso", ascending: true))
        sort.append(NSSortDescriptor(key: "dExameEspecial", ascending: true))
        request.sortDescriptors = sort
        
        do {
            let disciplinas = try contexto.fetch(request)
            app.lstUCs = disciplinas
            // Debug
            app.lstUCs.forEach({print($0.description)})
            app.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
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
    
    static func eliminaTodasDisciplinas() {
        let request = Disciplina.getDisciplinaRequest()
        
        do {
            let disciplinas = try contexto.fetch(request)
            disciplinas.forEach({ d in
                d.eliminaDisciplina()
            })
            app.saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func eliminaDisciplina(nome : String) {
        let disciplina = Disciplina.instanciaDisciplina(nome: nome)
        disciplina?.eliminaDisciplina()
    }
}
