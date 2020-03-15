//
//  adsViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 6/27/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SafariServices
import Firebase

struct brandDetail {
    var image: UIImage
    var url: String
    var brandLogo: String

    init(image: UIImage, url: String, brandLogo: String) {
        self.image = image
        self.url = url
        self.brandLogo = brandLogo
    }
}

class adsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var adDataList : [adImage] = [adImage]()
    var webLink : [String] = [String]()
    var sBrandLink : adImage!
 
    let gradient = CAGradientLayer()
    let borderz = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewBorder()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        receiveAds()
        tableView.reloadData()
        
        //GESTURE RECOGNIZER SETUP
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        navigationController?.isNavigationBarHidden = true
        navigationController?.view.semanticContentAttribute = .forceLeftToRight
        navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
    }
    
// MARK: - receive data from firebase server JSON
    func receiveAds() {
        
        let adverts = Database.database().reference().child("adSet").child("advertList")

        adverts.observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let snapshotValue = childSnapshot.value as! Dictionary<String, String>
                let adlogoTitle = snapshotValue["brandTitle"]!
                let adimg = snapshotValue["imageUrl"]!
                let adTitle = snapshotValue["linkTitle"]!
                let adurl = snapshotValue["urlLink"]!

                let advertList = adImage(imageurl: adimg, weburl: adurl, brandLogo: adlogoTitle, linkTitle: adTitle)
                
                self.adDataList.append(advertList)
                self.tableView.reloadData()
            }
        })
    }
    
// MARK: - TABLEVIEW BORDER
    func tableViewBorder() {
        gradient.frame = CGRect(origin: CGPoint.zero, size: self.tableView.frame.size)
        gradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        gradient.mask = borderz
        
        borderz.lineWidth = 2
        borderz.path = UIBezierPath(roundedRect: self.tableView.bounds, cornerRadius: 7).cgPath
        borderz.fillColor = UIColor.clear.cgColor
        tableView.layer.addSublayer(gradient)
    }
    
//SEGUE ACTION TRIGGERED BY RETURN BUTTON
    @IBAction func returnButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "mainView", sender: self)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended{
            switch sender.direction {
            case .right:
                self.performSegue(withIdentifier: "mainView", sender: self)
                break
            default:
                break
            }
        }
    }
}

//THIS BODY REFERENCES THE ADCELL.SWIFT FILE WITH SLINKDELEGATE
extension adsViewController: sLinkDelegate {
    func didTapStoreLink(url: String) {
        let sURL = URL(string: url)!
        let safaraiVC = SFSafariViewController(url: sURL)
        present(safaraiVC, animated: true, completion: nil)
    }
}

extension adsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let adImages = adDataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "adCell") as! adCell
        
        cell.sLabel.text = adDataList[indexPath.row].brandLogo
        cell.sButton.setTitle(adDataList[indexPath.row].linkTitle, for: .normal)
        
        if let advertImgURL = adImages.imageurl {
            cell.adImageView.loadCacheImageURL(urlString: advertImgURL)
        }
        
        cell.setAd(adImages: adImages)
        cell.sDelegate = self
        return cell
    }
}
