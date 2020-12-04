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

class TimelineTableViewController: UITableViewController {


    var groupArray: [[DiaryData]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if ParentClass.shared.mainData.count > 0 {
            groupArray = ParentClass.shared.mainData.groupSort(byDate: { ParentClass.shared.dateConvert(date: $0.date)})
            print(groupArray)
            print(groupArray.count)

        }else{
            apiCallingFuncation()

        }


        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")


    }

    func apiCallingFuncation(){

        WebServicesManager .getDirayData( onCompletion: { response in

            for Json in response!.arrayValue{
                let rowData = DiaryData.init(fromJson: Json)
                ParentClass.shared.mainData.append(rowData)
            }
            self.tableView.reloadData()
            ParentClass.shared.setJSON(json: ParentClass.shared.mainData, key: CS.Saved.DiaryData)

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

        var count : Int! = 0
         let lable = UILabel()
        for row in [groupArray[section][0]]{
            lable.text = row.date
        }
        return lable.text
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        print(groupArray[indexPath.section][indexPath.row].id)
        cell.descriptionLabel.text = groupArray[indexPath.section][indexPath.row].content
        cell.titleLabel.text =  groupArray[indexPath.section][indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        guard let sectionData = data[indexPath.section] else {
        //            return
        //        }
        //

        print(groupArray[indexPath.section][indexPath.row].title)
    }



}
extension Sequence {
    func groupSort(ascending: Bool = true, byDate dateKey: (Iterator.Element) -> Date) -> [[Iterator.Element]] {
        var categories: [[Iterator.Element]] = []
        for element in self {
            let key = dateKey(element)
            guard let dayIndex = categories.index(where: { $0.contains(where: { Calendar.current.isDate(dateKey($0), inSameDayAs: key) }) }) else {
                guard let nextIndex = categories.index(where: { $0.contains(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) }) else {
                    categories.append([element])
                    continue
                }
                categories.insert([element], at: nextIndex)
                continue
            }
            guard let nextIndex = categories[dayIndex].index(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) else {
                categories[dayIndex].append(element)
                continue
            }
            categories[dayIndex].insert(element, at: nextIndex)
        }
        return categories
    }
}
