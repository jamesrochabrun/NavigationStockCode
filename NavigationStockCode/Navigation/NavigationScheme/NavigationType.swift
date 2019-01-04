//
//  NavigationType.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/27/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

struct NavigationItems {
    
    var left: UIBarButtonItem?
    var right: UIBarButtonItem?
    var titleView: UIView?
}

enum NavigationType {
    
    case pin
    case standard
    case search
    case empty
}

extension NavigationType {

    var items: NavigationItems {
        switch self {
            
        case .pin:
            
            let pinButton = UIButton(type: .system)
            pinButton.translatesAutoresizingMaskIntoConstraints = false
            pinButton.setImage(#imageLiteral(resourceName: "pin").withRenderingMode(.alwaysOriginal), for: .normal)
            
            pinButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            pinButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            let backButton = UIButton(type: .system)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
            
            backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
           return NavigationItems(left: UIBarButtonItem(customView: backButton), right: UIBarButtonItem(customView: pinButton), titleView: nil)
        case .standard:
            
            // left
            let followButton = UIButton(type: .system)
           // followButton.translatesAutoresizingMaskIntoConstraints = false
            followButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            followButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            //  followButton.setImage(#imageLiteral(resourceName: "profile").withRenderingMode(.alwaysOriginal), for: .normal)
            followButton.backgroundColor = .black
            
            // right
            let searchButton = UIButton(type: .system)
            //  searchButton.setImage(#imageLiteral(resourceName: "zoom").withRenderingMode(.alwaysOriginal), for: .normal)
            searchButton.backgroundColor = .orange
            searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            let composeButton = UIButton(type: .system)
            composeButton.translatesAutoresizingMaskIntoConstraints = false
            composeButton.setImage(#imageLiteral(resourceName: "comp1").withRenderingMode(.alwaysOriginal), for: .normal)
            
            composeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            composeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            // center
            let titleImageView = UIImageView(image: #imageLiteral(resourceName: "yahoo"))
            titleImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
            titleImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            titleImageView.contentMode = .scaleAspectFit
            
            return NavigationItems(left:nil, right: UIBarButtonItem(customView: composeButton), titleView: titleImageView)
            
        default: return NavigationItems(left: nil, right: nil, titleView: nil)
        }
    }
}

protocol NavItemType {}

extension NavItemType where Self: UIViewController {
    
    func setUpNavItems(type: NavigationType, title: String? = nil, leftSelector: Selector? = nil, rightSelector: Selector? = nil) {
        
        let leftItem = type.items.left
        let leftButton = leftItem?.customView as? UIButton
        if let lSelector = leftSelector {
            leftButton?.addTarget(self, action: lSelector, for: .touchUpInside)
        }
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = type.items.right
        let rightButton = rightItem?.customView as? UIButton
        if let rSelector = rightSelector {
            rightButton?.addTarget(self, action: rSelector, for: .touchUpInside)
        }
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.navigationItem.titleView?.bounds = type.items.titleView?.frame ?? CGRect.zero //THIS FIX NEED RESEARCH
        self.navigationItem.titleView = type.items.titleView
        self.navigationItem.title = self.navigationItem.title ?? title
        /// Adding an image here will lead in not display title
    }
    
    func hideRightItem() {
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
    }
    
    func showRightItem() {
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = false
    }
}

