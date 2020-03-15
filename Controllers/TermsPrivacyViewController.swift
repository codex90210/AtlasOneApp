//
//  TermsPrivacyViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/12/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import PDFKit

class TermsPrivacyViewController: UIViewController {
    @IBOutlet weak var pdfText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func returnPrivacyButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
