//
//  BaseNavigationController.swift
//  ShareDiscount
//
//  Created by 吴文举 on 2018/4/9.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        navigationBar.barTintColor = UIColor.red
        navigationBar.isTranslucent = false;
    }
}
