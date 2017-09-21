//
//  FontTableViewCell.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 21/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class FontTableViewCell: UITableViewCell {

    @IBOutlet weak var fontLabel: UILabel!
    
    func configure(withFont font: String) {
        fontLabel.text = font
    }

}
