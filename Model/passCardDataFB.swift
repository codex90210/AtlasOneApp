//
//  passCardDataFB.swift
//  PremioBeta
//
//  Created by David Mompoint on 11/8/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import Foundation
import UIKit
//BLUEPRINT FOR COUPONCARDS IN MAINVIEWCONTROLLER

class passCardDatas {
    var passCard: String?
    var passCardDiscount: String?
    var passCardLogo: String?
    var passCardName: String?
    
    init(passCard: String, passCardDiscount: String, passCardLogo: String, passCardName: String) {
        self.passCard = passCard
        self.passCardDiscount = passCardDiscount
        self.passCardLogo = passCardLogo
        self.passCardName = passCardName
    }
}
