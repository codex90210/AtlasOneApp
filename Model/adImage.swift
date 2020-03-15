//
//  adImage.swift
//  PremioBeta
//
//  Created by David Mompoint on 6/30/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import Foundation
import UIKit

//BLUEPRINT FOR ADSVIEWCONTROLLER
class adImage {
    
    var imageurl: String?
    var weburl: String?
    var brandLogo: String?
    var linkTitle: String?
    
    init(imageurl: String, weburl: String, brandLogo: String, linkTitle: String){
        self.imageurl = imageurl
        self.weburl = weburl
        self.brandLogo = brandLogo
        self.linkTitle = linkTitle
    }
}

