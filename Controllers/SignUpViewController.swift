//
//  SignUpViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/13/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpReEnterPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpEmail.underlinedText()
        signUpPassword.underlinedText()
        signUpReEnterPW.underlinedText()
        
        signUpPlaceHolder()
    }
    
    //MARK: - SIGNUP LAYOUT DESIGN
    func signUpPlaceHolder() {
        signUpEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        signUpPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        signUpReEnterPW.attributedPlaceholder = NSAttributedString(string: "ReEnter Password",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    //MARK: - SIGNUP TRIGGER BUTTON FOR CONTINUE
    @IBAction func signUpContinue(_ sender: UIButton) {
        if signUpPassword.text != signUpReEnterPW.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: signUpEmail.text!, password: signUpPassword.text!){
                (user,error) in
                
                if error == nil {
                    self.performSegue(withIdentifier: "mainvc", sender: self)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
