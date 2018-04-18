//
//  CallerContentVC.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/10.
//

import UIKit

class CallerContentVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var customData : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        view.addSubview(tableView)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        customData = self.customDataSourse()
    }
    func customDataSourse() -> NSArray! {
        let filePath:String = NSHomeDirectory() + "/Documents/contacts.plist"
        var tmpDataSourse = NSArray(contentsOfFile: filePath)
        if tmpDataSourse == nil{
            tmpDataSourse =  ["领导", "老婆", "老公"]
            tmpDataSourse!.write(toFile: filePath, atomically: true)
        }
        return tmpDataSourse
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainCell(style: UITableViewCellStyle.default, reuseIdentifier: "MainCell")
        cell.leftTitleLabel.text = customData[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
}
