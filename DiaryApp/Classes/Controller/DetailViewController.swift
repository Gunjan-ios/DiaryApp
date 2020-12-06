//
//  DetailViewController.swift
//  DiaryApp
//
//  Created by Apple on 05/12/20.
//  Copyright © 2020 Gunjan. All rights reserved.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(content: String,title : String,id:String)
}

class DetailViewController: ParentClass {


    var delegate: MyDataSendingDelegateProtocol? = nil

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var btnSave: UIButton!

    var singleData: DiaryData!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = singleData.title
        btnSave.layer.cornerRadius = radius
        txtTitle.text = singleData.title
        txtContent.text  = singleData.content
        adjustUITextViewHeight(arg: txtContent)
        // Do any additional setup after loading the view.
    }
    // button save action
    @IBAction func UpdateDataButtonClicked(_ sender: Any) {

        if self.delegate != nil && self.txtContent.text != nil   && self.txtContent.text != nil{
            self.delegate?.sendDataToFirstViewController(content: txtContent.text!, title: txtTitle.text!, id: singleData.id)
            self.navigationController?.popViewController(animated: true)
        }
    }
    //textview height adjust
    func adjustUITextViewHeight(arg : UITextView)
    {
        txtContent.translatesAutoresizingMaskIntoConstraints = true
        txtContent.sizeToFit()
    }
}
