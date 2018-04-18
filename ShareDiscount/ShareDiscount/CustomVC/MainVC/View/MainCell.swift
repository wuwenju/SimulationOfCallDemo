//
//  MainCell.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/13.
//

import UIKit
import SnapKit
class MainCell: UITableViewCell {

    var rightTitleLabel = UILabel()
    var leftTitleLabel = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(rightTitleLabel)
        contentView.addSubview(leftTitleLabel)
        setUpviews()
    }
    
    func setUpviews() {
        
        self.leftTitleLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(5)
            make.right.equalTo(5)
            make.width.equalTo(self.rightTitleLabel.snp.height)
        })
        
        self.rightTitleLabel.snp.makeConstraints({ (make) in
//            make.left.equalTo(self.leftTitleLabel.snp.right).offset(10)
            make.right.equalTo(5)
            make.width.equalTo(50)
            make.centerY.equalTo(self.leftTitleLabel.snp.centerY)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
