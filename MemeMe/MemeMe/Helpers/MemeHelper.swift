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
        
        if topText.characters.count > 0 && bottomText.characters.count > 0 {
            _ = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: memeImage)
        }
    }
    
    static func generateMemedImage(_ viewController: PickImageViewController) -> UIImage {
        
        verifyViewControllerBars(true, viewController: viewController)
        
        // Render view to an image
        UIGraphicsBeginImageContext(viewController.view.frame.size)
        viewController.view.drawHierarchy(in: viewController.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        verifyViewControllerBars(false, viewController: viewController)
        
        return memedImage
    }
    
    private static func verifyViewControllerBars(_ enabled: Bool, viewController: PickImageViewController) {
        viewController.topBar.isHidden = enabled
        viewController.bottomBar.isHidden = enabled
    }
    
}
