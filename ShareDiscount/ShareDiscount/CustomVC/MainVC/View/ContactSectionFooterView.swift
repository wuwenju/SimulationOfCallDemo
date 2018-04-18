//
//  ContactSectionFooterView.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/17.
//

import UIKit
import SnapKit
class ContactSectionFooterView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let TF = UITextField()
    let BT = UIButton()
    var setContact: ((_ contact : String) -> ())?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(TF)
        contentView.addSubview(BT)
        setupView()
        contentView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        BT.setTitle("添加", for: UIControlState.normal)
        BT.setTitleColor(UIColor.black, for: UIControlState.normal)
        BT.addTarget(self, action:#selector(add),
                               for: .touchUpInside)

        TF.layer.cornerRadius = 6.0
        TF.clipsToBounds = true
        TF.backgroundColor = UIColor.white
        TF.snp.makeConstraints { (maker) in
            maker.left.equalTo(10)
            maker.top.equalTo(5)
            maker.bottom.equalTo(-5)
            maker.width.equalTo(100)
        }
        BT.snp.makeConstraints { (maker) in
            maker.right.equalTo(10)
            maker.top.equalTo(5)
            maker.bottom.equalTo(-5)
            maker.width.equalTo(100)
        }
    }
    
    @objc func add() {
            setContact!(TF.text!)
            TF.text = ""
    }
    
}

