//
//  DeleteAccountViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/9/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import FirebaseAuth

class DeleteAccountViewController: UIViewController {
    @IBOutlet weak var feedBack: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sadText: UILabel!
    @IBOutlet weak var reasonText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedBack.layer.borderWidth = 2
        feedBack.layer.borderColor = UIColor.white.cgColor
 
    }
    
    @IBAction func returnDel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendMsgButton(_ sender: UIButton) {
        messageDisplay()
    }
    
//INFORMATION SENT TO SERVER ABOUT USER DELETING ACCOUNT
    @IBAction func deleteAccount(_ sender: UIButton) {
        
        let user = Auth.auth().currentUser
    
        user?.delete { error in
            if error != nil {
                print("An error Occurred")
            }
            else {
                print("Account Deleted")
                self.performSegue(withIdentifier: "continue", sender: self)
            }
        }
        print("User Deleted Account")
    }
    
//MARK: - FEEDBACK REASON FOR ACCOUNT DELETION
    func messageDisplay() {
        let errorMessage = "Please Enter A Message."
        
        if feedBack.text == "" || feedBack.text.contains(errorMessage) {
            feedBack.text = errorMessage
            feedBack.isEditable = true
            
            //This information below is sent to user's profile in backend server
            print("User Left No Message")
        } else {
            
            //FADE BORDER COLORS
            feedBack.animateBorderColor(toColor: .clear, duration: 1.5)
            animateTextColor()
            
            //DISPLAYS CENTER ALIGNED THANK YOU MESSAGE
            sendButton.isHidden = true
            feedBack.textAlignment.self = NSTextAlignment.center
            feedBack.text = "Thank You For Sharing"
            //print(feedBack.text as Any)
        }
    }
//MARK: TEXT COLOR ANIMATION
    func animateTextColor() {
        UIView.transition(with: sadText, duration: 1.5, options: .transitionCrossDissolve, animations: {
          self.sadText.textColor = .clear
        }, completion: nil)
        
        UIView.transition(with: reasonText, duration: 1.5, options: .transitionCrossDissolve, animations: {
          self.reasonText.textColor = .clear
        }, completion: nil)
    }
}

extension UITextView {
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
}

