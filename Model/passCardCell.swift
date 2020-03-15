//
//  passCardCell.swift
//  PremioBeta
//
//  Created by David Mompoint on 8/2/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit

class passCardCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoNameLabel: UILabel!
    @IBOutlet weak var logoDiscLabel: UILabel!
    
    //MODEL FOR PASSCARDS (USED IN MAINVIEWCONTROLLER)
    func setCardData(cardData: passCardDatas) {
        logoNameLabel.text = cardData.passCardName
        logoDiscLabel.text = cardData.passCardDiscount
    }
    
//BORDER COLOR
    func setUpGradient() {
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.black.cgColor
        
    }
}
