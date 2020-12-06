//
//  GISWebServicesManager.swift
//  TestSpatialite
//
//  Created by Gaurav on 20/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import JQProgressHUD

let BASE_URL = "https://private-ba0842-gary23.apiary-mock.com/notes"


class WebServicesManager {
    
    class func getDirayData(onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

//        Hud.showLoading(title: CS.Common.waiting)
        let strUrl = "\(BASE_URL)"
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .get, parameters:nil,encoding: JSONEncoding.default).responseJSON { (response) in
//            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }
}
