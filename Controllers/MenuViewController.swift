//
//  MenuViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/3/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func returnMenu(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
//MARK: - LOGOUT & CLEANING DATA
    @IBAction func logOut(_ sender: UIButton) {
        do {
            cleaningData()
            try Auth.auth().signOut()
            
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
}

//CLEANING DATA FROM PHONE FOR PERSONALIZED USER EXPERIENCE AND SECURITY
func cleaningData() {
    
    var ref: DatabaseReference!
    
    let userID = Auth.auth().currentUser?.uid
    
    ref = Database.database().reference().child("Used List").child((userID)!)
        ref.removeAllObservers()
    usedCouponList.removeAll()
    print(usedCouponList)
}

//MARK: - TEXTFIELD LAYOUT DESIGN
extension UITextField {
    
    func underlinedText() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width , height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
