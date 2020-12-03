//
//  ViewController.swift
//  DiaryApp
//
//  Created by Apple on 03/12/20.
//  Copyright © 2020 Gunjan. All rights reserved.
//

import UIKit

class ViewController: ParentClass {

    override func viewDidLoad() {
        super.viewDidLoad()
//        apiCallingFuncation()
        // Do any additional setup after loading the view.
    }
    func apiCallingFuncation(){

        WebServicesManager .getDirayData( onCompletion: { response in
            if response!["status"].boolValue == true {
//                let userData = User.init(fromJson: response!["data"])

//                ParentClass.shared.saveJSON(json:response!["data"] , key: CS.Saved.loginData)
                self.performSegue(withIdentifier:CS.Segue.goHome , sender: self)


            } else {

                Utils.showAlert(targetVC: self, title: "Network error", message: "Unable to contact the server", style: .alert)
            }

        },onError:{ error in

            if error != nil {
                Utils.showAlert(targetVC: self, title: "Network error", message: "Unable to contact the server", style: .alert)
            }
        })
    }

}

