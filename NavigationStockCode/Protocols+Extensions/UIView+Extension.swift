//
//  UIView+Extension.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/29/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSafeSubView(_ view: UIView?) {
        guard let v = view else { return }
        self.addSubview(v)
    }
}
