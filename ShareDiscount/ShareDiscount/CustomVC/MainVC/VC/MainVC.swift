//
//  MainVC.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/9.
//

import UIKit
class MainVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var customData : Array<MainModel>!
    var tableView : UITableView!
    var delayTime = 0.0
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
    
    func customDataSourse() -> Array<MainModel> {
        var tmpCustomData =  Array<MainModel>()
        let tmpRight =  ["时间", "来电人", "铃声震动" , "来电内容","壁纸", "隐藏黑屏倒计时"]
        for tmpRightTitle in tmpRight {
            let mainModel = MainModel()
            mainModel.leftTitle = tmpRightTitle
            tmpCustomData.append(mainModel)
        }
        return tmpCustomData
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
        
        cell.leftTitleLabel.text = customData[indexPath.row].leftTitle
        if indexPath.row == 0 {
            if delayTime > 0{
                cell.rightTitleLabel.text = customData[indexPath.row].rightTitle
            }else{
                cell.rightTitleLabel.text = "立即"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        let mainModel = customData[indexPath.row]
        let backItem = UIBarButtonItem()
        backItem.tintColor = UIColor.green
        backItem.title = mainModel.leftTitle
        self.navigationItem.backBarButtonItem = backItem
        if mainModel.leftTitle == "时间" {
            self.loadPickerView()
        }else if mainModel.leftTitle == "来电人"{
            self.navigationController?.pushViewController(ContactSettingVC(), animated: true)
        }else if mainModel.leftTitle == "铃声震动"{
            self.navigationController?.pushViewController(RingtoneVibrationSettingVC(), animated: true)
        }
        else if mainModel.leftTitle == "来电内容"{
     
            self.navigationController?.pushViewController(CallerContentVC(), animated: true)
        }
        else if mainModel.leftTitle == "壁纸"{
            self.navigationController?.pushViewController(WallpaperSettingVC(), animated: true)
        }

    }

    func setDelayTime(_ time:Double , text:String){
        let mainModel = customData[0]
        mainModel.rightTitle = text
        delayTime = time
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
