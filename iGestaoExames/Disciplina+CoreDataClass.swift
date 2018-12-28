//
//  Disciplina+CoreDataClass.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 28/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//
//

import Foundation
import CoreData

protocol OrdenarDisciplinas {
    func ordenaPorNome()
    func ordenaPorPlanoCurricular()
    func ordenaPorDataDoExame()
}

public class Disciplina: NSManagedObject {

    override public var description: String {
        return "UC: \(nome) - \(ano)º ano \(semestre)º semestre \nExame Normal: \(dExameNormal.string()) Exame Recurso: \(dExameRecurso.string()) Exame Especial: \(dExameEspecial.string())"
    }
    
    static func getDisciplinaRequest() -> NSFetchRequest<Disciplina> {
        return Disciplina.fetchRequest()
    }
}
