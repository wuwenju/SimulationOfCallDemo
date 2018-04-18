//
//  MainVC_Extension.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/11.
//

import UIKit
private var pickerViewTag: UInt = 0

extension MainVC:UIPickerViewDelegate, UIPickerViewDataSource {
    
    /*
     1.extension
     2.convenience
     */
    private var pickerView:WWJPickerView!{
        get {
            var tmpPickerView =   (objc_getAssociatedObject(self, &pickerViewTag) as? WWJPickerView)
            if tmpPickerView == nil{
                tmpPickerView = WWJPickerView()
                objc_setAssociatedObject(self, &pickerViewTag, tmpPickerView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
          return  (objc_getAssociatedObject(self, &pickerViewTag) as? WWJPickerView)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &pickerViewTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func loadPickerView() {
        pickerView = WWJPickerView()
        pickerView.frame = CGRect.init(x: 0, y: self.view.frame.height - 200, width: self.view.frame.width, height: 200)
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self
        
        pickerView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        //设置选择框的默认值
        pickerView.selectRow(0,inComponent:0,animated:true)
//        pickerView.selectRow(2,inComponent:1,animated:true)
//        pickerView.selectRow(3,inComponent:2,animated:true)
        self.view.addSubview(pickerView)
        pickerView.reloadAllComponents()
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let donwButton = UIButton(frame:CGRect(x:pickerView.frame.width - 70, y: 0, width:60, height:30))
        donwButton.setTitle("确定",for:.normal)
        donwButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        donwButton.addTarget(self, action:#selector(getPickerViewValue),
                         for: .touchUpInside)
        pickerView.doneBT = donwButton
        pickerView.addSubview(donwButton)
        
        let cancleButton = UIButton(frame:CGRect(x:10, y: 0, width:60, height:30))
        cancleButton.setTitle("取消",for:.normal)
        cancleButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        cancleButton.addTarget(self, action:#selector(dismissPickerView),
                         for: .touchUpInside)
        pickerView.cancleBT = cancleButton
        pickerView.addSubview(cancleButton)
    }
 
    

    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return 39
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return String(row)+"-"+String(component)
    }
    
    //触摸按钮时，获得被选中的索引
    @objc func getPickerViewValue(){
        self.dismissPickerView()
        self.setDelayTime(delayTime(pickerView.selectedRow(inComponent: 0), with: 0) ,  text: rowText(pickerView.selectedRow(inComponent: 0), with: 0))
    }

    //触摸按钮时，获得被选中的索引
    @objc func dismissPickerView(){
        pickerView.removeFromSuperview()
    }

    func rowText(_ row: Int, with Component: Int) -> String {
        var text = ""
        if(row <= 0){
            text = "立即"
        }else if(row < 12){
            text = String(row * 5)+"秒"
        }else if(row < 17){
            text = String((row - 11))+"分"
        }else if(row < 27){
            text = String((row - 15) * 5)+"分"
        }else if(row < 39){
            text = String(row - 26)+"小时"
        }
        return text
    }
    
    func delayTime(_ row: Int, with Component: Int) -> Double {
        var time = 0.0
        if(row <= 0){
        }else if(row < 12){
            time += (Double)(row * 5)
        }else if(row < 17){
            time += (Double)((row - 11) * 60)
        }else if(row < 27){
            time += (Double)((row - 15) * 5 * 60)
        }else if(row < 39){
            time += (Double)((row - 26) * 60 * 60)
        }
        return time
    }

    
    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if(0 == component){
//            //第一列变宽
//            return 100
//        }else{
//            //第二、三列变窄
//            return 30
//        }
//    }
    
//    //设置行高
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
//        -> CGFloat {
//            return 50
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,
                    reusing view: UIView?) -> UIView {
//        let image = UIImage(named:"icon_"+String(row))
//        let imageView = UIImageView()
//        imageView.image = image
//        return imageView
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 15)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.rowText(row, with: component)
        return pickerLabel!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        print(component)
        print(row)
    }
}
