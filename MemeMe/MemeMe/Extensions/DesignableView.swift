//
//  DesignableView.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 21/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

@IBDesignable
open class DesignableView: UIView {
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
}
