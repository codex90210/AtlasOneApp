//
//  ThankYouViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/2/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    @IBOutlet weak var Message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLayoutField()
        gradientBorder()
    }
    
    @IBAction func returnNavButton(_sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - GRADIENT BORDER LAYOUT
    func gradientBorder() {
        
        let gradientCard = CAGradientLayer()
        gradientCard.frame = CGRect(origin: CGPoint.zero, size: self.Message.frame.size)
        gradientCard.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        
        let bezelCard = CAShapeLayer()
        bezelCard.lineWidth = 7
        bezelCard.path = UIBezierPath(rect: self.Message.bounds).cgPath
        bezelCard.strokeColor = UIColor.black.cgColor
        bezelCard.fillColor = UIColor.clear.cgColor
        
        gradientCard.mask = bezelCard
        
        self.Message.layer.addSublayer(gradientCard)
    }
    
    //MARK: - MESSAGE DESIGN
    func messageLayoutField() {
        Message.text = "Thank you for shopping.\n You've exceeded your coupon limit."
        Message.layer.shadowOffset = CGSize(width: 7, height: 7)
        Message.layer.shadowPath = UIBezierPath(rect: Message.bounds).cgPath
        Message.layer.shadowColor = UIColor.gray.cgColor
        Message.layer.shadowRadius = 2
        Message.layer.shadowOpacity = 0.5
    }
}
