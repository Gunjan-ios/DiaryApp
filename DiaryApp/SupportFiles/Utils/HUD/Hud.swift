//
//  Hud.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import JQProgressHUD

class Hud {
    
    static func showLoading(title : String)  {
        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    }
    static func hideLoading()  {
        JQProgressHUDTool.jq_hideHUD()
    }
    
}
