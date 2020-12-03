////
////  ShopeLivUtilities.swift
////  ShopeLiv
////
////  Created by Suresh on 01/03/18.
////  Copyright © 2018 Gunjan. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//class ExzUtilities: NSObject {
//
//    static let shared = ExzUtilities()
//    private override init() { }
//
//
//    //MARK: Logged in userID
//    var siteId: Int? {
//        get {
//            return UserDefaults.standard.integer(forKey: CS.Params.site_id)
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.set(value, forKey: CS.Params.site_id)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var device_id: String? {
//        get {
//           return UserDefaults.standard.object(forKey: CS.Params.device_id) as? String
//
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.device_id)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//
//    var student_id : String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.student_id) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.student_id)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
////    var siteName : String? {
////        get {
////            return UserDefaults.standard.object(forKey: CS.Params.site_name) as? String
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: CS.Params.site_name)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
////
//    var leftMenuName : [String]? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.sideMenu) as? [String]
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.sideMenu)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var address : String? {
//          get {
//              return UserDefaults.standard.object(forKey: CS.Params.address) as? String
//          }
//          set {
//              if let value = newValue {
//                  UserDefaults.standard.setValue(value, forKey: CS.Params.address)
//                  UserDefaults.standard.synchronize()
//              }
//          }
//      }
//    var address1 : String? {
//             get {
//                 return UserDefaults.standard.object(forKey: CS.Params.address1) as? String
//             }
//             set {
//                 if let value = newValue {
//                     UserDefaults.standard.setValue(value, forKey: CS.Params.address1)
//                     UserDefaults.standard.synchronize()
//                 }
//             }
//         }
//    var phonenumber : String? {
//          get {
//              return UserDefaults.standard.object(forKey: CS.Params.phoneNumber) as? String
//          }
//          set {
//              if let value = newValue {
//                  UserDefaults.standard.setValue(value, forKey: CS.Params.phoneNumber)
//                  UserDefaults.standard.synchronize()
//              }
//          }
//      }
//
//    var lastName : String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.last_name) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.last_name)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//
//    var email : String? {
//        get {
//            return UserDefaults.standard.object(forKey:CS.Params.email) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.email)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var password : String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.password) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.password)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var photo : String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.photo) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey:CS.Params.photo)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//
////    var isWalkThroughShowed: Bool? {
////        get {
////            guard let flag = UserDefaults.standard.object(forKey: Macros.kSettingWalkThroughShowedAdding) as? Bool else {
////                return false
////            }
////
////            return flag
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: Macros.kSettingWalkThroughShowedAdding)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
////    var isStoreAdded: Bool? {
////        get {
////            return UserDefaults.standard.object(forKey: Macros.kSettingStoreAdding) as? Bool
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: Macros.kSettingStoreAdding)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
//
////    var provider: String? {
////        get {
////            return UserDefaults.standard.object(forKey: Macros.kSettingUserProvider) as? String
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: Macros.kSettingUserProvider)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
//    //MARK: Logged in first name
//    var firstname: String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.first_name) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.first_name)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    //MARK: Logged in last name
//    var lastname: String? {
//        get {
//            return UserDefaults.standard.object(forKey: CS.Params.last_name) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.last_name)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//
////    var isProfileStatusAdded: Bool? {
////        get {
////            return UserDefaults.standard.object(forKey: Macros.kSettingProfileStatusAdding) as? Bool
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: Macros.kSettingProfileStatusAdding)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
////
//    //MARK: media_base_url
////    var MediaUrl: String? {
////        get {
////            return UserDefaults.standard.object(forKey: Constant.KMediaUrl) as? String
////        }
////        set {
////            if let value = newValue {
////                UserDefaults.standard.setValue(value, forKey: Constant.KMediaUrl)
////                UserDefaults.standard.synchronize()
////            }
////        }
////    }
//}
//
//extension Date {
//
//    var  formatter: DateFormatter { return DateFormatter() }
//
//    var convertToString: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        let str = dateFormatter.string(from: self)
//        return str
//    }
//}
//
//
//// MARK: - Asynchronous Image download
//let imageCache = NSCache<AnyObject, AnyObject>()
//
//class CustomImageView: UIImageView {
//
//    var imageUrlString: String?
//
//    func loadImageUsingUrlString(_ urlString: String) {
//
//        imageUrlString = urlString
//
//        guard let url = URL(string: urlString) else { return }
//
//        image = nil
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
//
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async(execute: {
//
//                if let data = data{
//                    if let imageToCache = UIImage(data: data){
//
//                        if self.imageUrlString == urlString {
//                            self.image = imageToCache
//                        }
//                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
//                    }
//                }
//            })
//        }).resume()
//    }
//}
//
