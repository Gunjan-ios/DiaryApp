//
//  ParentViewController.swift
//  GEM
//
//  Created by Gunjan Raval on 8/23/18.
//  Copyright © 2018 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON

class ParentClass: UIViewController{

    static let shared = ParentClass()

    // ----------------------------------------------------------
    // MARK: Private Members
    // ----------------------------------------------------------

    var APP = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var lblSubTitle : UILabel!
    //    var mainData : DiaryData!
    var mainData : [DiaryData] = [DiaryData]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let imgNav = UIView (frame: CGRect (x: 0, y: 0, width: SCREEN_WIDTH, height: STATUS_BAR_HEIGHT))
        imgNav.backgroundColor = colorPrimary
        self.view.addSubview(imgNav)


        self.lblSubTitle = UILabel (frame: CGRect (x: X_PADDING, y: 0, width: SCREEN_WIDTH - X_PADDING*2, height: SCREEN_HEIGHT))
        //            lblSubTitle.center = CGPoint (x: self.view.center.x, y: lblSubTitle.center.y)
        self.lblSubTitle.text =  CS.Common.NoData
        self.lblSubTitle.numberOfLines = 0
        self.lblSubTitle.lineBreakMode = .byWordWrapping
        self.lblSubTitle.textAlignment = .center
        self.lblSubTitle.font = UIFont (name: APP_FONT_NAME_BOLD, size: HEADER_FONT_SIZE)
        self.lblSubTitle.textColor = .white
        self.lblSubTitle.isHidden = true
        self.view.addSubview(self.lblSubTitle)
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setData(strData:Any,strKey:String) {

        UserDefaults.standard.set(strData, forKey: strKey)
        UserDefaults.standard.synchronize()
    }

    func getDataForKey(strKey:String) -> Any {
        return UserDefaults.standard.value(forKey: strKey) as Any
    }

    func detectScreenShot(action: @escaping () -> ()) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { notification in
            // executes after screenshot
            action()
        }
    }

    func getDate(date:String)-> String {
        if (date == ""){
            return date
        }
        let splitdate : [Substring] = date.split(separator: ".")
        let subString = splitdate.first!
        let newDate = String(subString)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date1 = dateFormatterGet.date(from:newDate ){
            dateFormatterPrint.timeZone = TimeZone.current
            dateFormatterPrint.timeStyle = .medium //Set time style
            dateFormatterPrint.dateStyle = .medium //Set date style
            //            dateFormatterPrint.dateFormat = "yyyy-MM-dd  HH:mm:ss"
            return dateFormatterPrint.string(from:date1)
        }
        else {
            print("There was an error decoding the string")
        }
        return date
    }
    func dateConvert(date: String?) -> Date{

        //        let isoDate = date
        //print(isoDate)
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        //
        //        let date = dateFormatter.date(from:isoDate!)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: date!)
        print("date: \(date)")

        return date!

        //        if let timeResult = date {
        //            let date = NSDate(timeIntervalSince1970: timeResult)
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.timeStyle = .medium //Set time style
        //            dateFormatter.dateStyle = .medium //Set date style
        //            let localDate = dateFormatter.string(from: date as Date)
        //            return localDate
        //        }else{
        //            return ""
        //        }
    }
    func getDataJSON(key:String) -> [DiaryData] {
        if let listArray = self.getDataForKey(strKey: key) as? Data {
            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [DiaryData] {
                return decodedArray
            }
        }
        return [DiaryData]()
    }

    func setJSON(json: [DiaryData], key:String)  {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject:json)
        self.setData(strData: encodedData, strKey: key)
    }
    func saveJSON(json: JSON, key:String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }

    func getJSON(_ key: String)-> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    //    public func loadJSON(strKey:String) -> JSON {
    //        let defaults = UserDefaults.standard
    //        return JSON (parseJSON: (defaults.value(forKey: strKey) as! String))
    ////        return JSON.parse(defaults.valueForKey(strKey) as! String))
    //        // JSON from string must be initialized using .parse()
    //    }
    // get color from string

    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {

        if (toInterfaceOrientation.isLandscape) {
            NSLog("Landscape");
        }
        else {
            NSLog("Portrait");
        }
    }
    func getColorFromString(pString:String) -> UIColor {

        var strokeColorInString = pString
        strokeColorInString = strokeColorInString.replacingOccurrences(of: "rgba(", with: "")
        strokeColorInString = strokeColorInString.replacingOccurrences(of: ")", with: "")

        let strokesArray = strokeColorInString.components(separatedBy: ",")

        return UIColor(red:  CGFloat(Double(strokesArray[0])!/255.0), green: CGFloat(Double(strokesArray[1])!/255.0), blue: CGFloat(Double(strokesArray[2])!/255.0), alpha:  CGFloat(Double(strokesArray[3])!))
    }
    //    @objc func networkStatusChanged(_ notification: Notification) {
    //
    //        let status = Reach().connectionStatus()
    //        switch status {
    //        case .unknown, .offline:
    //            print("Not connected")
    //            APP.open_count = 2
    ////           self.processingAlert?.show(nil, hidden: nil)
    //         case .online(.wwan):
    //            print("Connected via WWAN")
    //            self.processingAlert?.hideAlert({ () -> () in
    //                if self.APP.open_count == 2 {
    //                    self.APP.open_count = 0
    ////                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
    //                }
    //                    })
    //        case .online(.wiFi):
    //            print("Connected via WiFi")
    //
    //            self.processingAlert?.hideAlert({ () -> () in
    //                if self.APP.open_count == 2 {
    //                    self.APP.open_count = 0
    ////                    self.showAlert(message: Language.Common.Connected, type: AlertType.success, navBar: false)
    //                }
    //                    })
    //        }
    //    }




    func heightForView(text:String?, width:CGFloat , Label : UILabel) -> Int{
        let hValue = CGFloat.greatestFiniteMagnitude
        Label.frame.size.height = hValue
        Label.numberOfLines = 0
        Label.lineBreakMode = NSLineBreakMode.byWordWrapping
        Label.text = text
        Label.sizeToFit()
        //if Int(Label.frame.height) < LABEL_HEIGHT || Int(Label.frame.height)  <= 41 {

        if Int(Label.frame.height) < CUSTOM_TEXTFIELD_HEIGHT  {
            return CUSTOM_TEXTFIELD_HEIGHT
        }
        else{
            return Int(Label.frame.height)
        }
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
