//
//  UIViewController+Extension.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/29/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
