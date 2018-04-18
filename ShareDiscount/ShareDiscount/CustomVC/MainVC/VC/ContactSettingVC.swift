//
//  ContactSettingVC.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/10.
//

import UIKit

class ContactSettingVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var customData : NSMutableArray!
    let filePath:String = NSHomeDirectory() + "/Documents/contacts.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        view.addSubview(tableView)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(ContactSectionFooterView.self, forHeaderFooterViewReuseIdentifier:"ContactSectionFooterView")
        customData = self.customDataSourse()
        self.title = "来电人"
    }
    func customDataSourse() -> NSMutableArray! {
        var tmpDataSourse = NSMutableArray(contentsOfFile: filePath)
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainCell(style: UITableViewCellStyle.default, reuseIdentifier: "MainCell")
        cell.leftTitleLabel.text = customData[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactSectionFooterView") as! ContactSectionFooterView
        footer.setContact = {
            (contact:String)->() in
            if  contact == "" {
                let alertController = UIAlertController(title: "提醒", message: "不能为空", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "好的", style: .default, handler:{action  in
                    print("点击了确定")
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return;
            }

            self.customData.add(contact)
            self.customData.write(toFile: self.filePath, atomically: true)
            tableView.reloadData()
        }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
    

}
