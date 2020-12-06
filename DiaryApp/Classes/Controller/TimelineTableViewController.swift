//
//  TimelineTableViewController.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit
import SwiftyJSON
//import TimelineTableViewCell

class TimelineTableViewController: UITableViewController,MyDataSendingDelegateProtocol {

//update data from details page
    func sendDataToFirstViewController(content: String, title: String,id:String) {

        for dic in ParentClass.shared.mainData{
            if dic.id == id {
                dic.content = content
                dic.title = title
                dataGroupAndSave()
            }
        }
    }


    var groupArray: [[DiaryData]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checking for save data
        if ParentClass.shared.mainData.count > 0 {
            groupArray = ParentClass.shared.mainData.groupSort(byDate: { ParentClass.shared.dateConvert(date: $0.date)})
        }else{
            apiCallingFuncation()
        }
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }

    //api calling for dairydata
    func apiCallingFuncation(){

        WebServicesManager .getDirayData( onCompletion: { response in

            for Json in response!.arrayValue{
                let rowData = DiaryData.init(fromJson: Json)
                ParentClass.shared.mainData.append(rowData)
            }
            self.dataGroupAndSave()

        },onError:{ error in

            if error != nil {
                Utils.showAlert(targetVC: self, title: "Network error", message: "Unable to contact the server", style: .alert)
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groupArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int! = 0
        for row in [groupArray[section]]{
            count = row.count
        }
        print(count as Any)
        return count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         let lable = UILabel()
        for row in [groupArray[section][0]]{
            print(Utils.getDate(complete: row.date))
            lable.text = Utils.getDate(complete: row.date)
        }
        return lable.text
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        cell.descriptionLabel.text = groupArray[indexPath.section][indexPath.row].content
        cell.titleLabel.text =  groupArray[indexPath.section][indexPath.row].title
        let id = groupArray[indexPath.section][indexPath.row].id!
        cell.btnDelete.tag =  Int(id)!
        cell.btnDelete.addTarget(self, action: #selector(TimelineTableViewController.deleteRow(sender:)) , for: .touchUpInside)
        return cell
    }

    @objc  func deleteRow(sender :UIButton)  {
        let tag = sender.tag
        if let object = ParentClass.shared.mainData.filter({ $0.id == String(tag) }).first {
            let index = ParentClass.shared.mainData.firstIndex(of: object)
            ParentClass.shared.mainData.remove(at: index!)
            dataGroupAndSave()
        }
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVc =  self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailsVc.singleData = groupArray[indexPath.section][indexPath.row]
        detailsVc.delegate = self
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }
}
extension TimelineTableViewController{

    func dataGroupAndSave(){
        ParentClass.shared.setJSON(json: ParentClass.shared.mainData, key: CS.Saved.DiaryData)
        self.groupArray = ParentClass.shared.mainData.groupSort(byDate: { ParentClass.shared.dateConvert(date: $0.date)})
        self.tableView.reloadData()
    }
}

extension Sequence {
    func groupSort(ascending: Bool = true, byDate dateKey: (Iterator.Element) -> Date) -> [[Iterator.Element]] {
        var categories: [[Iterator.Element]] = []
        for element in self {
            let key = dateKey(element)
            guard let dayIndex = categories.firstIndex(where: { $0.contains(where: { Calendar.current.isDate(dateKey($0), inSameDayAs: key) }) }) else {
                guard let nextIndex = categories.firstIndex(where: { $0.contains(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) }) else {
                    categories.append([element])
                    continue
                }
                categories.insert([element], at: nextIndex)
                continue
            }
            guard let nextIndex = categories[dayIndex].firstIndex(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) else {
                categories[dayIndex].append(element)
                continue
            }
            categories[dayIndex].insert(element, at: nextIndex)
        }
        return categories
    }
}
