//
//  AccountViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/4/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var reEnterPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.underlinedText()
        emailText.underlinedText()
        passwordText.underlinedText()
        reEnterPassword.underlinedText()
        
        //MARK: - SETTING AUTHENTICATION
        let userInfo = Auth.auth().currentUser
        
        if let userInfo = userInfo {
            let email = userInfo.email
            emailText.text = email
            
        }
        //TODO NEED TO SET VALUE FROM FIREBASE UID
        nameText.text = "David"
    }
    
    @IBAction func returnAccount(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - UPDATE SETTINGS ACTION
    @IBAction func editSettings(_ sender: Any) {
        nameText.isUserInteractionEnabled = true
        emailText.isUserInteractionEnabled = true
        passwordText.isUserInteractionEnabled = true
        reEnterPassword.isUserInteractionEnabled = true
        
        updateUser()
    }
    
    //MARK: - SAVE SETTINGS ACTION
    @IBAction func saveButton(_ sender: Any) {
        nameText.isUserInteractionEnabled = false
        emailText.isUserInteractionEnabled = false
        passwordText.isUserInteractionEnabled = false
        reEnterPassword.isUserInteractionEnabled = false
        
        matchingPassword()
    }
    
    //MARK: - UPDATE PASSWORD & PASSWORD CONFIRMATION
    func matchingPassword() {
        
        Auth.auth().currentUser?.updatePassword(to: passwordText.text!) { (error) in
            
            if error != nil {
                //ERROR OCCURED
                let alertOne = UIAlertController(title: "Update Error", message: error?.localizedDescription, preferredStyle: .alert)
                alertOne.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default"), style: .default, handler: { _ in NSLog("Continue")}))
                self.present(alertOne, animated: true, completion: nil)
                self.credSettings()
                print("Error")
            }
                
            else if self.reEnterPassword.text != self.passwordText.text {
                //ERROR MISMATCH PW OCCURED
                let alert = UIAlertController(title: "Update Error", message: "Password must match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default"), style: .default, handler: { _ in NSLog("Continue")}))
                self.present(alert, animated: true, completion: nil)
                self.credSettings()
                print("Error")
            }
            else {
                //PASSWORD UPDATED
                let alertTwo = UIAlertController(title: "Password Update", message: "Password Successfully Updated!", preferredStyle: .alert)
                alertTwo.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Default"), style: .default, handler: { _ in NSLog("Continue")}))
                self.present(alertTwo, animated: true, completion: nil)
                self.credUpdated()
                print("Success")
            }
        }
    }
    
    //MARK: - SETTING PASSWORD CREDENTIALS
    func credSettings() {
        self.passwordText.text = ""
        self.reEnterPassword.text = ""
        self.passwordText.isUserInteractionEnabled = true
        self.reEnterPassword.isUserInteractionEnabled = true
    }
    
    //MARK: CLEARING TEXT FIELD AFTER PASSWORD UPDATE
    func credUpdated() {
        self.passwordText.text = ""
        self.reEnterPassword.text = ""
        self.passwordText.isUserInteractionEnabled = false
        self.reEnterPassword.isUserInteractionEnabled = false
    }
    //MARK: - UPDATE USER CREDENTIALS
    func updateUser() {
        let user = Auth.auth().currentUser
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: "email" , password: "password")
        
        
        //PROMPT TO RE-ENTER THEIR SIGN-IN CREDENTIALS
        user?.reauthenticate(with: credential, completion: {(authResult, error) in
            if error != nil {
                //an error occured.
            } else {
                // user re-authenticated
            }
        })
    }
}

