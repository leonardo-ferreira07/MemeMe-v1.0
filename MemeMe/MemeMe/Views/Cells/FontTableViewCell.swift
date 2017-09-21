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
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.strokeColor: UIColor.black,
        NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont(name: font, size: 20)!,
        NSAttributedStringKey.strokeWidth: -5.0]
        fontLabel.attributedText = NSMutableAttributedString(string: font, attributes: attributes)
    }

}
