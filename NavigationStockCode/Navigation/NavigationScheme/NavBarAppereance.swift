//
//  NavBarAppereance.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

enum NavBarAppereance {
    
    case standard
    case custom // any custom or special case should be handled here, it can be renamed
    
    var style: (barTintColor: UIColor?, tintColor: UIColor?, titleTextAttributes: [NSAttributedString.Key: Any], isTranslucent: Bool, largeTitle: Bool) {
        switch self {
        case .standard: return (#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1), .white, titleTextAttributes, false, false)
        case .custom: return (#colorLiteral(red: 0.6275901198, green: 0.4403616786, blue: 0.9657108188, alpha: 1), #colorLiteral(red: 0.6275901198, green: 0.4403616786, blue: 0.9657108188, alpha: 1), titleTextAttributes, false, false)
        }
    }
    
    private var titleTextAttributes: [NSAttributedString.Key: Any] {
        switch self {
        case .standard: return  [NSAttributedString.Key.foregroundColor: UIColor.red]
        case .custom: return  [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}

extension NavBarAppereance {
    
    init(controller: RootController) {
        switch controller {
        // for example we want home have a red color
        case .home: self = .custom
        default: self = .standard
        }
    }
}


