//
//  CustomNavigationController.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    // MARK:- Private properties
    private var controllerScheme: RootController!
    var customView: UIView?
    
    var heightCustomView: CGFloat {
        return 70
    }
    
    // MARK:- Public properties
    
    // MARK:- Init
    convenience init(rootViewController: UIViewController, scheme: RootController) {
        self.init(rootViewController: rootViewController)
        self.controllerScheme = scheme
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBarAppereance()
        removeBottomShadow()
    }
    
    // MARK:- Configuration Private
    private func setUpNavigationBarAppereance() {
        
        self.navigationBar.barTintColor = controllerScheme.navBarAppereance.style.barTintColor
        self.navigationBar.tintColor = controllerScheme.navBarAppereance.style.tintColor
        self.navigationBar.backgroundColor = controllerScheme.navBarAppereance.style.barTintColor
        self.navigationBar.titleTextAttributes = controllerScheme.navBarAppereance.style.titleTextAttributes
        self.navigationBar.isTranslucent = controllerScheme.navBarAppereance.style.isTranslucent
        self.navigationBar.prefersLargeTitles = controllerScheme.navBarAppereance.style.largeTitle
    }
    
    private func removeBottomShadow() {
        
        // Removes line separator at bottom of navigation bar
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // add a custom view to the topcontroller?
        
        let customViewForNavBar = UIView()
        customViewForNavBar.translatesAutoresizingMaskIntoConstraints = false
        customViewForNavBar.backgroundColor = #colorLiteral(red: 0.6275901198, green: 0.4403616786, blue: 0.9657108188, alpha: 1)
        guard let vc = self.topViewController else { return }
        vc.view.addSubview(customViewForNavBar)
        customViewForNavBar.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        customViewForNavBar.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        customViewForNavBar.heightAnchor.constraint(equalToConstant: heightCustomView).isActive = true
        customViewForNavBar.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        
        self.customView = OverlappedSelector(items: [#imageLiteral(resourceName: "messi"), #imageLiteral(resourceName: "pz"), #imageLiteral(resourceName: "zidane")], borderColor: .white)
        customViewForNavBar.addSubview(self.customView!)
        
        self.customView?.translatesAutoresizingMaskIntoConstraints = false
        self.customView?.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.customView?.centerYAnchor.constraint(equalTo: customViewForNavBar.centerYAnchor).isActive = true
        self.customView?.trailingAnchor.constraint(equalTo: customViewForNavBar.trailingAnchor, constant: -20).isActive = true
        self.customView?.heightAnchor.constraint(equalTo: customViewForNavBar.heightAnchor, multiplier: 0.65).isActive = true
    }
}

