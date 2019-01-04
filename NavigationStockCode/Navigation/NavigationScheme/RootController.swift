//
//  RootController.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

enum RootController: CaseIterable {
    
    case home
    case deals
    case flights
    case photo
    case dashboard
    case people
    case contacts
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .deals: return "deals"
        case .dashboard: return "dashboard"
        case .flights: return "flights"
        case .people: return "people"
        case .photo: return "photo"
        case .contacts: return "contacts"
        }
    }
    
    var iconImage: UIImage? {
        return nil
        switch self {
        case .home: return #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal)
        case .deals: return #imageLiteral(resourceName: "money")
        case .flights: return #imageLiteral(resourceName: "air-freight")
        case .photo: return #imageLiteral(resourceName: "photo-camera")
        default: return nil
        }
    }
    
    var tabBarTitle: String {
        switch self {
        //  add any case that needs a custom tab bar name
        default: return self.title
        }
    }
    
    var controller: UIViewController.Type {
        switch self {
        case .home: return HomeVC.self
        case .deals: return DealsVC.self
        case .flights: return FlightsVC.self
        case .photo: return PhotosVC.self
        case .dashboard: return DashBoardVC.self
        case .people: return PeopleVC.self
        case .contacts: return ContactsVC.self
        }
    }
    
    var navBarAppereance: NavBarAppereance {
        return NavBarAppereance(controller: self)
    }
}
