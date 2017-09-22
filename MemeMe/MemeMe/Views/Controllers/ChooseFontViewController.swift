//
//  ChooseFontViewController.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 21/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class ChooseFontViewController: UIViewController {

    enum FontCell: String {
        case fontCell
    }
    
    @IBOutlet weak var contentView: DesignableView!
    
    var fonts: [String] = []
    var callbackFont: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for family: String in UIFont.familyNames {
            for name: String in UIFont.fontNames(forFamilyName: family) {
                fonts.append(name)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateIn()
    }
    
    // MARK: - Animations
    
    func prepareForAnimation() {
        contentView.isHidden = true
    }
    
    func animateIn() {
        contentView.animateShowPopingUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func exitClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - TableView Delegate and Data Source

extension ChooseFontViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FontCell.fontCell.rawValue, for: indexPath) as? FontTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FontTableViewCell {
            cell.configure(withFont: fonts[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callbackFont?(fonts[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
}
