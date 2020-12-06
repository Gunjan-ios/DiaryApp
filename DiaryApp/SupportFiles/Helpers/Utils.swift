//
//  Utils.swift
//  iBeacon
//
//  Created by Gunjan on 02/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import JQProgressHUD
import Foundation
import SwiftyJSON


class Utils: NSObject {

    static func getAlertController(title : String, message : String ,style: UIAlertController.Style) ->  UIAlertController {

        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alertVc.view.tintColor = colorPrimary
        let attrs = [kCTFontAttributeName as NSAttributedString.Key:UIFont.boldSystemFont(ofSize: 18.0),kCTForegroundColorAttributeName as NSAttributedString.Key:colorPrimary]
        let hogen = NSMutableAttributedString.init(string: title, attributes: attrs)
        alertVc.setValue(hogen,forKey: "attributedTitle")
        let attrsM  = [kCTFontAttributeName as NSAttributedString.Key:UIFont.systemFont(ofSize: 15.0) ,kCTForegroundColorAttributeName as NSAttributedString.Key:UIColor.black]
        let hogenMessage = NSMutableAttributedString.init(string: message, attributes: attrsM)
        alertVc.setValue(hogenMessage,forKey: "attributedMessage")
        return alertVc
    }

    static  func showAlert(targetVC: UIViewController, title: String, message: String ,style: UIAlertController.Style){
        DispatchQueue.main.async(execute: {
            let alert = getAlertController(title : title, message : message, style: style)
            alert.addAction((UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            })))

            targetVC.present(alert, animated: true, completion: nil)
        })
    }
    static func getDate(complete date:String)-> String {
        if (date == ""){
            return date
        }
        let splitdate : [Substring] = date.split(separator: ".")
        let subString = splitdate.first!
        let newDate = String(subString)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"

        if let date1 = dateFormatterGet.date(from:newDate ){
            return dateFormatterPrint.string(from:date1)
        }
        else {
            print("There was an error decoding the string")
        }
        return date
    }
    static func attributedString(str : String) -> NSAttributedString? {
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.foregroundColor : colorPrimaryDark,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        return attributedString
    }
    static func mulitplelinebutton(strText :NSString , btn :UIButton){


        let fulltext : String = strText as String
        //getting the range to separate the button title strings
        let newlineRange: NSRange = strText.range(of: "\n")

        //getting both substrings
        var substring1 = ""
        var substring2 = ""

        if(newlineRange.location != NSNotFound) {
            substring1 = strText.substring(to: newlineRange.location)
            substring2 = strText.substring(from: newlineRange.location)
        }

        //assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont .boldSystemFont(ofSize:SMALL_BUTTON_FONT_SIZE)
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: colorSubHeading_76
        ]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)


        let font2: UIFont = UIFont .systemFont(ofSize:  SUB_LABEL_DESC_FONT_SIZE)
        let attributes2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: colorSubSubHeading_94
        ]

        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)

        attrString1.append(attrString2)

        //assigning the resultant attributed strings to the button
        btn.setAttributedTitle(attrString1, for: [])

    }
    //    static func showLoading(title : String)  {
    //        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    //    }
    //    static func hideLoading()  {
    //        JQProgressHUDTool.jq_hideHUD()
    //    }
    static func mimeType(for data: Data) -> String {

        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)

        switch b {
            case 0xFF:
                return "image/jpeg"
            case 0x89:
                return "image/png"
            case 0x47:
                return "image/gif"
            case 0x4D, 0x49:
                return "image/tiff"
            case 0x25:
                return "application/pdf"
            case 0xD0:
                return "application/vnd"
            case 0x46:
                return "text/plain"
            default:
                return "application/octet-stream"
        }
    }
    //    static func stringFromJson(object: [[String : Any]]) -> String{
    //        let newjson = JSON(object)
    //        let sjod = newjson.rawString()
    //        return sjod!
    ////        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
    ////        let jsonString = String(data: jsonData!, encoding: .utf8)
    ////        return jsonString!
    //    }
    //    static func jsonObject(jsonString : String) -> [[String : Any]] {
    //        let jsonData = jsonString.data(using: .utf8)
    //        let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options:  [])
    //        return dictionary as! [[String : Any]]
    //    }
    static func dataFromJson(object: [String : Any]) -> Data {
        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
        if(jsonData == nil){
            return Data()
        }
        return jsonData!
    }
    static func jsonFromData(data : Data)-> [String : Any] {
        let dictionary = try? JSONSerialization.jsonObject(with: data, options: [])
        if(dictionary == nil){
            return [:]
        }
        return dictionary as! [String : Any]
    }
    static func stringFromJson(object: [String : Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    static func jsonObject(jsonString : String) -> [String : Any] {
        let jsonData = jsonString.data(using: .utf8)
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options:  [])
        return dictionary! as! [String : Any]
    }
    static func getTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                if textField.text == "" {
                    //                    ParentClass.shared.checkTextfield = 1
                }else{
                    results += [textField]
                }
            } else {
                results += getTextfield(view: subview)
            }
        }
        return results
    }
    static func cStoreGetTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                if textField.text == "" && (textField.tag == 112 || textField.tag == 114  || textField.tag == 116 || textField.tag == 118  || textField.tag == 128  || textField.tag == 130  || textField.tag == 132) {
                    //                    ParentClass.shared.checkTextfield = 1
                }else{
                    results += [textField]
                }
            } else {
                results += cStoreGetTextfield(view: subview)
            }
        }
        return results
    }
    //    && (textField.tag != 101 || textField.tag != 102 || textField.tag != 103 || textField.tag != 104 || textField.tag != 105 || textField.tag != 106 || textField.tag != 107 || textField.tag != 108 || textField.tag != 109 || textField.tag != 110 || textField.tag != 111 || textField.tag != 112 || textField.tag != 113)
    static func registerTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                if  textField.text == ""  && textField.tag != 0 {
                    //                    ParentClass.shared.checkTextfield = 1
                }else{
                    results += [textField]
                }
            } else {
                results += registerTextfield(view: subview)
            }
        }
        return results
    }

    static func keyboardTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                results += [textField]
            } else {
                results += registerTextfield(view: subview)
            }
        }
        return results
    }

    static func stringFromJson(object: [JSON]) -> String{
        let newjson = JSON(object)
        let sjod = newjson.rawString()
        return sjod!
        //        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
        //        let jsonString = String(data: jsonData!, encoding: .utf8)
        //        return jsonString!
    }
    //    static func jsonObject(jsonString : String) -> JSON {
    //        let jsonData = jsonString.data(using: .utf8)
    //        if (jsonData != nil) {
    //            let finalJSON = try? JSON(data: jsonData!)
    //            return finalJSON!
    //        }
    //        else{
    //            return JSON()
    //        }
    //    }
}

extension Array {
    func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur[keyPath: key])
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }

        return groupedByDateComponents
    }
}
