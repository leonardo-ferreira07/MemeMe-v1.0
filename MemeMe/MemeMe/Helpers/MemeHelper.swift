//
//  MemeHelper.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 20/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

struct MemeHelper {
    
    static func save(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        _ = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: memeImage)
    }
    
    static func generateMemedImage(_ viewController: PickImageViewController) -> UIImage {
        
        viewController.topBar.isHidden = true
        viewController.bottomBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(viewController.view.frame.size)
        viewController.view.drawHierarchy(in: viewController.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        viewController.topBar.isHidden = false
        viewController.bottomBar.isHidden = false
        
        return memedImage
    }
    
}
