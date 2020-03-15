//
//  ViewController.swift
//  PremioBeta
//
//  Created by David Mompoint on 6/23/19.
//  Copyright © 2019 ATLASONE. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase

var usedCouponList: [String] = []

class ViewController: UIViewController, UIPopoverControllerDelegate {
    
    @IBOutlet var imageOne: UIImageView!
    //@IBOutlet var codeCoupon: UITextView!
    
    @IBOutlet var codeCoupon: UILabel!
    @IBOutlet var activateCode: UIButton!
    @IBOutlet weak var passCardBck: RoundImage!
    
    //@IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var timerClock: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var loaderWheel: UIActivityIndicatorView!
    
    //@IBOutlet var backGroundView: UIView!
    var adImageOne: UIImage!
    var adImageTwo: UIImage!
    
    var count: Timer!
    var clockTime = 300
    var activateCounter = 0
    var passCardData: passCardDatas?
    
    
    var xfilter : CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        discountLabel.text = passCardData?.passCardDiscount
        brandLabel.text = passCardData?.passCardName
        loaderWheel.isHidden = false
        loaderWheel.isOpaque = true
        loaderWheel.startAnimating()
        setPassCardUI()
        
        perform(#selector(loaderStop), with: nil, afterDelay: 1)
        
        codeCoupon.isHidden = true
        imageOne.isHidden = true
        
        codeCoupon.layer.masksToBounds = true
        codeCoupon.layer.cornerRadius = 5
    }
    
    @objc func loaderStop() {
        self.loaderWheel.isHidden = true
        self.loaderWheel.stopAnimating()
    }
    //MARK: - SET PASSCARD DATA
    //set and load coupon card
    func setPassCardUI () {
        let section = passCardData
        
        if let cardURL = section?.passCard {
            passCardBck.loadCacheImageURL(urlString: cardURL)
            
        }
        passCardBck.clipsToBounds = true
    }
    
    //MARK: - LAYOUT DESIGN FOR ACTIVATE & RETURN BUTTON
    func setupLayout() {
        
        let buttonGradient = CAGradientLayer()
        buttonGradient.frame = CGRect(origin: CGPoint.zero, size: self.activateCode.frame.size)
        buttonGradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        
        let buttonBezel = CAShapeLayer()
        buttonBezel.lineWidth = 2
        buttonBezel.path = UIBezierPath(roundedRect: self.activateCode.bounds, cornerRadius: 7).cgPath
        buttonBezel.strokeColor = UIColor.black.cgColor
        buttonBezel.fillColor = UIColor.clear.cgColor
        buttonGradient.mask = buttonBezel
        
        self.activateCode.layer.addSublayer(buttonGradient)
        self.activateCode.layer.masksToBounds = true
        self.activateCode.layer.cornerRadius = 7
        
        // RETURN BUTTON SETUP
        
        let retGradient = CAGradientLayer()
        retGradient.frame = CGRect(origin: CGPoint.zero, size: self.returnButton.frame.size)
        retGradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        
        let retBezel = CAShapeLayer()
        retBezel.lineWidth = 2
        retBezel.path = UIBezierPath(roundedRect: self.returnButton.bounds, cornerRadius:7).cgPath
        retBezel.strokeColor = UIColor.black.cgColor
        retBezel.fillColor = UIColor.clear.cgColor
        retGradient.mask = retBezel
        
        self.returnButton.layer.addSublayer(retGradient)
        self.returnButton.layer.masksToBounds = true
        self.returnButton.layer.cornerRadius = 7
    }
    
    //MARK: - RETURN BUTTON TRIGGER EVENT
    @IBAction func returnButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - COUNTDOWN ACTION
    func countDown () {
        count = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatedTime), userInfo: nil, repeats: true)
    }
    
    @objc  func updatedTime () {
        timerClock.text = "\(timeFormat(clockTime))"
        
        if clockTime != 0 {
            clockTime -= 1
        } else {
            endClock()
            codeCoupon.isHidden = true
            imageOne.isHidden = true
        }
    }
    
    func endClock () {
        count.invalidate()
    }
    
    func timeFormat(_ entireCount: Int) -> String {
        let minutes: Int = (entireCount / 60) % 60
        let seconds: Int = entireCount % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //MARK: - ACTIVATE COUPON CODE BUTTON
    @IBAction func activateCoupon(_ sender: Any) {
        
        //ALERT HANDLER & CONDITIIONAL SETUP
        let alertMessage = "By selecting continue, the timer will activate. If you exit the page before timmer expires, you'll no longer be able to access selected coupon"
        let alert = UIAlertController.init(title: "", message: alertMessage, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
            
            
            //TRIGGER ACTIVATION CODE
            self.activationSetup()
            self.timeClock()
            self.countDown()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(continueAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - ACTIVATION TIME CLOCK SETUP
    func activationSetup() {
        
        var sectionTwo: String {
            var result = ""
            repeat {
                result = String(format: "%04d", arc4random_uniform(10000))
            } while Set<Character>(result).count < 4
            return result
        }
        
        func random(_ n: Int) -> String {
            
            let a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var s = ""
            for _ in 0..<n {
                let r = Int(arc4random_uniform(UInt32(a.count)))
                s += String(a[a.index(a.startIndex, offsetBy: r)])
            }
            return s
        }
        
        let finalCode = sectionTwo + "-" + random(4)
        
        let data = finalCode.data(using: .ascii, allowLossyConversion: false)
        
        xfilter = CIFilter(name: "CIQRCodeGenerator")
        
        xfilter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        let image = UIImage(ciImage: xfilter.outputImage!.transformed(by: transform))
        
        imageOne.image = image
        imageOne.tintColor = UIColor.black
        
        codeCoupon.text = finalCode
        codeCoupon.backgroundColor = UIColor.white
        codeCoupon.alpha = CGFloat(0.75)
        codeCoupon.textColor = UIColor.black
        
        activateCode.isHidden = true
        imageOne.isHidden = false
        codeCoupon.isHidden = false
    }
    //MARK: - TIMECLOCK FUNCTION SETUP
    func timeClock () {
        let time = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mma"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let clockString = formatter.string(from: time)
        
        activateCounter += 1
        print(activateCounter, "Brand: ", (passCardData!.passCardName)!,clockString)
        
        usedCouponList.append((passCardData!.passCardName)!)
        print("Used Coupon List: \(usedCouponList)")
        
        //saveData()
        //saving appended usedcoupon list to firebase
        couponDatabase()
        
    }
    
    //MARK: - SAVING COUPON LIST TO FIREBASE SERVER
    //Data Persistance via Firebase. Sending usedCouponList array into JSON to Firebase.
    
    func couponDatabase() {
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference().child("Used List").child((userID)!)
        let usedList = ["Sender": Auth.auth().currentUser?.email! as Any, "List": usedCouponList] as [String : Any]
        ref.setValue(usedList) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("Data saved")
            }
        }
    }
}

//MARK: - ROUND IMAGE DESIGN
@IBDesignable class RoundImage: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
}

//MARK: - ROUND LABEL DESIGN

@IBDesignable class RoundLabel: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
}

//MARK: - GRADIENT COLOR SET

@IBDesignable class gradientColorUI: UIView {
    
    @IBInspectable var gradientColorOne: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColorTwo: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.setGradient()
        }
    }
    
    private func setGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [self.gradientColorOne.cgColor, self.gradientColorTwo.cgColor]
        gradientLayer.startPoint = self.gradientStartPoint
        gradientLayer.endPoint = self.gradientEndPoint
        gradientLayer.frame = self.bounds
        
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            topLayer.removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - GRADIENT COLOR FOR NAVIGATION BAR

@IBDesignable class gradientNavUI: UINavigationBar {
    
    @IBInspectable var gradientColorOne: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColorTwo: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.setGradient()
        }
    }
    
    private func setGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [self.gradientColorOne.cgColor, self.gradientColorTwo.cgColor]
        gradientLayer.startPoint = self.gradientStartPoint
        gradientLayer.endPoint = self.gradientEndPoint
        gradientLayer.frame = self.bounds
        
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            topLayer.removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - GRADIENT COLOR FOR UIBUTTON
@IBDesignable class gradientUIButton: UIButton {
    
    @IBInspectable var gradientColorOne: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColorTwo: UIColor = UIColor.white {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet {
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.setGradient()
        }
    }
    
    private func setGradient() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [self.gradientColorOne.cgColor, self.gradientColorTwo.cgColor]
        gradientLayer.startPoint = self.gradientStartPoint
        gradientLayer.endPoint = self.gradientEndPoint
        gradientLayer.frame = self.bounds
        
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            topLayer.removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
