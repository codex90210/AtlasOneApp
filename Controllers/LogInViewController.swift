//
//  LogInViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/13/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet weak var logInEmail: UITextField!
    @IBOutlet weak var logInPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInEmail.underlinedText()
        logInPassword.underlinedText()
        
        myPlaceholder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyEntry(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        view.endEditing(true)
    }
    
    @objc func dismissKeyEntry(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func logInReturn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - PLACEHOLDER DESIGN - PASSWORD & EMAIL
    func myPlaceholder() {
        logInPassword.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        logInEmail.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
//MARK: - LOG IN BUTTON AUTHENTICAITON
    @IBAction func logIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: logInEmail.text!, password: logInPassword.text!) { (user, error) in
            
            if error == nil {
                self.performSegue(withIdentifier: "loginvc", sender: self)
                readingData()
                print(usedCouponList)
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

//MARK: - READING DATA FROM FIREBASE - LOGIN
// Body allows data (used coupon list) to be pulled from firebase when users log in. Called in Log in function above
func readingData() {
    
    var ref: DatabaseReference!
    
    let userID = Auth.auth().currentUser?.uid
    
    ref = Database.database().reference().child("Used List").child((userID)!)
    
    ref.observe(.value, with: { (snap: DataSnapshot) in
        if let listDict = snap.childSnapshot(forPath: "List").value as? [String] {
            usedCouponList = listDict
            print(listDict)
        }
    })
}
