//
//  Meme+UIViewController.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 21/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func presentActivityController(withImage image: UIImage, completion: (() -> Void)?) {
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler = { (_, success, _, _) in
            if let completion = completion, success {
                completion()
            } else {
                print("error while sharing")
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
