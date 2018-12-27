//
//  TableViewCell.swift
//  iGestaoExames
//
//  Created by Sarah Ferreira Mendes da Cunha on 19/12/2018.
//  Copyright © 2018 AMov - ISEC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Propriedades
    
    @IBOutlet weak var nomeUC: UILabel!
    @IBOutlet weak var anoSemUC: UILabel!
    @IBOutlet weak var dExameNormal: UILabel!
    @IBOutlet weak var dExameRecurso: UILabel!
    @IBOutlet weak var dExamespecial: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
