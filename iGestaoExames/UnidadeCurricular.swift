//
//  UnidadeCurricular.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 19/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import Foundation

class UnidadeCurricular : Comparable {
    
    
    var nome : String
    var ano : Int
    var semestre : Int
    var dExameNormal : Date
    var dExameRecurso : Date
    var dExameEspecial : Date
    
    init(nome: String, ano: Int, semestre: Int, dExameNormal: Date, dExameRecurso: Date, dExameEspecial: Date) {
        self.nome = nome
        self.ano = ano
        self.semestre = semestre
        self.dExameNormal = dExameNormal
        self.dExameRecurso = dExameRecurso
        self.dExameEspecial = dExameEspecial
    }
    
    var strAnoSem : String {
        return "\(ano)º A / \(semestre)º S"
    }
    
    var descricao : String {
        return "UC: \(nome) - \(ano)º ano \(semestre)º semestre \nExame Normal: \(dExameNormal) Exame Recurso: \(dExameRecurso) Exame Especial: \(dExameEspecial)"
    }
    
    static func < (lhs: UnidadeCurricular, rhs: UnidadeCurricular) -> Bool {
        return (lhs.ano + lhs.semestre) < (rhs.ano + rhs.semestre)
    }
    
    static func == (lhs: UnidadeCurricular, rhs: UnidadeCurricular) -> Bool {
        return (lhs.ano + lhs.semestre) == (rhs.ano + rhs.semestre)
    }
    
}

extension Date {
    func string() -> String {
        let format = "dd-MM-yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
