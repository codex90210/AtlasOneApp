//
//  resetPasswordViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/21/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class resetPasswordViewController: UIViewController {
    @IBOutlet weak var resetEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetEmail.underlinedText()
        resetPlaceholder()
    }
    
    @IBAction func resetReturn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - PASSWORD RESET FUNCTION
    @IBAction func resetPWButton(_ sender: UIButton) {
        
        Auth.auth().sendPasswordReset(withEmail: resetEmail.text!) { (error) in
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAct = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAct)
                self.present(alertController, animated: true, completion: nil)
            } else {
                
                let resetAlert = UIAlertController(title: "Link Sent", message: "Please check your inbox for the link we have sent your inbox to reset your password", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.performSegue(withIdentifier: "showlogin", sender: self)})
                resetAlert.addAction(defaultAction)
                
                self.view.endEditing(true)
                self.present(resetAlert, animated: true, completion: nil)
            }
            
        }
    }
//MARK: - LAYOUT DESIGN FOR RESET EMAIL FIELD
    func resetPlaceholder() {
        resetEmail.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

}
