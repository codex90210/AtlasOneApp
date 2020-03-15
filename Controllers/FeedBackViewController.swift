//
//  FeedBackViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/11/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedBackViewController: UIViewController {
    @IBOutlet weak var feedBackField: UITextField!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutFieldDesign()
    }
    
    @IBAction func sendMessageButton(_ sender: UIButton) {
        messageFeedBack()
    }
    
    @IBAction func returnFB(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - FEEDBACK MESSAGE SENT TO FIREBASE SERVER
    func messageFeedBack() {
        
        let errorMessage = "Please Enter A Message."

          if textField.text == "" || textField.text.contains(errorMessage) {
              textField.text = errorMessage
              textField.isEditable = true
            
              //This information below is sent to user's profile in backend server
              print("User Left No Message")
          } else {
            
              //This information below is sent to user's profile in backend server
            let ref = Database.database().reference().child("messages")
            let feedback = ["Sender": Auth.auth().currentUser?.email, "subject": feedBackField.text!, "message": textField.text!]
            ref.childByAutoId().setValue(feedback) {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                } else {
                    print("message saved successfully!")
                }
            }
              
            print(feedBackField.text!)
            print(textField.text!)
          }
      }

//MARK: - FEEDBACK & TEXTFIELD LAYOUT
    func layoutFieldDesign() {
        
        feedBackField.underlinedText()
        feedBackField.attributedPlaceholder = NSAttributedString(string: "Subject", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
    }
}
