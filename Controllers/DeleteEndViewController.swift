//
//  DeleteEndViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 10/16/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import UIKit

class DeleteEndViewController: UIViewController {
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(DeleteEndViewController.doStuff), userInfo: nil, repeats: false)
    }
    
    @objc func doStuff() {
        timer.invalidate()
        self.performSegue(withIdentifier: "firstpage", sender: self)
    }

}
