//
//  CustomTabBarController.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit


class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        viewControllers = RootController.allCases.map { navController(with: $0) }
    }
    
    private func navController(with rootController: RootController) -> UINavigationController {

        // Customize the navigation item of the rootcontroller
        let vc = rootController.controller.init()
        vc.navigationItem.title = rootController.title

        // Customize tab bar
        let navC = CustomNavigationController(rootViewController: vc, scheme: rootController)
        navC.tabBarItem.title = rootController.title
        navC.tabBarItem.image = rootController.iconImage
        
        return navC
    }
}
