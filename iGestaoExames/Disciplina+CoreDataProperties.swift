//
//  Disciplina+CoreDataProperties.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 28/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

let app = UIApplication.shared.delegate as! AppDelegate
let contexto = app.context

extension Disciplina {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Disciplina> {
        return NSFetchRequest<Disciplina>(entityName: "Disciplina")
    }

    @NSManaged public var ano: Int16
    @NSManaged public var dExameEspecial: Date
    @NSManaged public var dExameNormal: Date
    @NSManaged public var dExameRecurso: Date
    @NSManaged public var nome: String
    @NSManaged public var semestre: Int16

    class func instanciaDisciplina(nome: String) -> Disciplina? {
        let request = Disciplina.getDisciplinaRequest()
        let predicate = NSPredicate(format: "nome = $@", nome)
        request.predicate = predicate
        
        do {
            let disciplinas = try contexto.fetch(request)
            return disciplinas.first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func editaDisciplina(nome : String, ano : Int, semestre : Int, exameNormal : Date, exameRecurso : Date, exameEspecial : Date) {
        self.nome = nome
        self.ano = Int16(ano)
        self.semestre = Int16(semestre)
        self.dExameNormal = exameNormal
        self.dExameRecurso = exameRecurso
        self.dExameEspecial = exameEspecial
        
        app.saveContext()
    }
    
    func eliminaDisciplina() {
        contexto.delete(self)
        app.saveContext()
    }    
}
