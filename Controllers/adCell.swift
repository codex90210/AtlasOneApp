//
//  adCell.swift
//  PremioBeta
//
//  Created by David Mompoint on 6/29/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//
import UIKit
import SafariServices
import Firebase

protocol sLinkDelegate {
    
    func didTapStoreLink(url: String)
}

struct webData {
    var urlLink: String
    
    init(urlLink: String) {
        self.urlLink = urlLink
    }
}

class adCell: UITableViewCell {
    
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var contentCell: UIView!
    
    var webListDatas : webData!
    var dataList : [webData] = [webData]()
    var sDelegate: sLinkDelegate?
    
    var webLinkURL: adImage!
    
    func setAd(adImages: adImage) {

        webLinkURL = adImages
        
        setLayout()
        contentBorder()
    }
    
    //TRIGGER SAFARI SERVICES
    @IBAction func sxButton(_ sender: UIButton) {
        sDelegate?.didTapStoreLink(url: webLinkURL.weburl!)
        print(webLinkURL.weburl!)
        
    }
    
    func contentBorder() {
        
        contentCell.layer.borderWidth = 0.5
        contentCell.layer.borderColor = UIColor.darkGray.cgColor
        contentCell.layer.frame = CGRect(x: 0.0, y: self.contentCell.frame.size.height - 1.0, width: self.contentCell.frame.size.width, height: 1.0)
        
    }
    //MARK: - Rounding Shop Button: sButton
    func setLayout() {
        
        sButton.layer.masksToBounds = true
        sButton.layer.cornerRadius = 7
        
        sButton.layer.borderWidth = 1.5
        sButton.layer.borderColor = UIColor.black.cgColor
        
        sButton.backgroundColor = .white
        sButton.titleLabel?.textColor = .black
        
        sButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        
        //MARK: - Gradient Border Around AdImageView
        
        let imgGradient = CAGradientLayer()
        imgGradient.frame = CGRect(origin: CGPoint.zero, size: self.adImageView.frame.size)
        imgGradient.colors = [UIColor.black.cgColor]

        //SETTING BEZEL LAYER
        let bezelImage = CAShapeLayer()
        bezelImage.lineWidth = 3
        bezelImage.path = UIBezierPath(roundedRect: self.adImageView.bounds, cornerRadius: 0).cgPath
        bezelImage.fillColor = UIColor.clear.cgColor
        bezelImage.strokeColor = UIColor.white.cgColor
        imgGradient.mask = bezelImage
        
        //ADIMAGEVIEW LAYER
        adImageView.layer.masksToBounds = true
        adImageView.layer.addSublayer(imgGradient)
        
        //STORE LABEL BACKGROUND COLOR
        sLabel.backgroundColor = UIColor(red: 0.45, green: 0.55, blue: 0.69, alpha: 0.65)

    }

}
