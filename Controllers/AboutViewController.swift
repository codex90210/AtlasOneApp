//
//  AboutViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/11/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var aboutField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutField.isEditable = false

    }
    
    @IBAction func returnAbout(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
