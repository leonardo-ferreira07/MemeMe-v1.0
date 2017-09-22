//
//  Meme+UIView.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 22/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

extension UIView {
    
    public func animateShowPopingUp(duration: Double = 0.4, scaleIn: CGFloat = 0.1, scaleOut: CGFloat = 1.05, alphaIn: CGFloat = 0, _ completion:(() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.isHidden = false
            self.alpha = alphaIn
            self.transform = CGAffineTransform(scaleX: scaleIn, y: scaleIn)
            
            UIView.animate(withDuration: duration * 0.7, animations: {
                self.transform = CGAffineTransform(scaleX: scaleOut, y: scaleOut)
                self.alpha = 1
            }, completion: { (_) in
                UIView.animate(withDuration: duration * 0.3, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (_) in
                    completion?()
                })
            })
        }
    }
    
    public func animateShakeUpDown(duration: Double = 0.17) {
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shake.duration = 0.50
        shake.values = [30.0, 15.0, -20.0, -10.0, 0.0]
        
        self.layer.add(shake, forKey: "AwesomeMagicUIShakeUpDown")
    }
}
