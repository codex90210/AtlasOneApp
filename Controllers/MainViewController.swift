//
//  MainViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 7/30/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController, UIPopoverControllerDelegate {

    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var couponTableView: UITableView!
    
    var passCardFB: [passCardDatas] = [passCardDatas]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        couponTableView.delegate = self
        couponTableView.dataSource = self

        couponTableView.rowHeight = 81
        couponTableView.separatorColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.85)
       
        receivePassCard()
    
//MARK: TableView tap gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        navigationController?.view.semanticContentAttribute = .forceRightToLeft
        navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended{
            switch sender.direction {
            case .left:
                self.performSegue(withIdentifier: "adView", sender: self)
                break
            default:
                break
            }
        }
    }
    
//MARK: - RETREIVE COUPON DETAILS FROM FIREBASE
    
    func receivePassCard() {
        let passCardDB = Database.database().reference().child("PassCard").child("Coupons")
        
        passCardDB.observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let snapshotValue = childSnapshot.value as! Dictionary<String, String>
                let Card = snapshotValue["couponCard"]!
                let Discount = snapshotValue["couponDiscount"]!
                let Logo = snapshotValue["couponLogoImg"]!
                let Name = snapshotValue["couponLogoName"]!
                
                let passCards = passCardDatas(passCard: Card, passCardDiscount: Discount, passCardLogo: Logo, passCardName: Name)
                
                self.passCardFB.append(passCards)
                self.couponTableView.reloadData()
            }
        })
    }
    
//MARK: - SEGUE ACTION
    @IBAction func shopButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "adView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "discountView" {
            let destVC = segue.destination as! ViewController
            destVC.passCardData = sender as? passCardDatas
        }
    }
}
//MARK: - SEPERATOR COLORS
//func sepColors() {
//
//    let sepGradient = CAGradientLayer()
//    let sepBorders = CAShapeLayer()
//
//    let width = CGFloat(1.0)
//
//    sepGradient.frame = CGRect(origin: CGPoint.zero, size: self.couponTableView.frame.size)
//    sepGradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
//    sepGradient.mask = sepBorders
//
//    sepBorders.lineWidth = 1
//    sepBorders.path = UIBezierPath(cgPath: self.couponTableView.bounds).cgPath
//    sepBorders.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
//
//    self.couponTableView.layer.addSublayer(sepGradient)
//}

//MARK: - TABLEVIEW SECTION 
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passCardFB.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let couponCell = couponTableView.dequeueReusableCell(withIdentifier: "passCardCell") as! passCardCell
        let sections = passCardFB[indexPath.row]
        couponCell.logoNameLabel.text = passCardFB[indexPath.row].passCardName
        couponCell.logoDiscLabel.text = passCardFB[indexPath.row].passCardDiscount
        
        if let passCardURL = sections.passCardLogo {
            
            couponCell.logoImageView.loadCacheImageURL(urlString: passCardURL
        )}
        
        couponCell.setUpGradient()
        return couponCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let couponList = passCardFB[indexPath.row]
    
        //traded  usedCouponList.contains(couponList.couponLogoName) for -->
        if usedCouponList.contains(couponList.passCardName!)  {
            performSegue(withIdentifier: "google", sender: couponList)
        } else{
             performSegue(withIdentifier: "discountView", sender: couponList)
        }
    }
}
