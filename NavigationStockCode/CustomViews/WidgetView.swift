//
//  WidgetView.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/31/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

protocol WidgetViewDelegate: class {
    func widgetViewDidTapped(_ dataSource: String)
    func widgetDidSwipped()
}

class WidgetView: UIView {
    
    var dataSource: String?
    
    let actionsView: UIImageView = {
        let v = UIImageView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    weak var delegate: WidgetViewDelegate?
    
    convenience init(dataSource: String, screenShot: UIImage) {
        self.init()
        self.dataSource = dataSource
        configure(screenShot)
        setUpAppereance()
        setUpGestures()
    }
    
    private func configure(_ screenShot: UIImage) {
        self.addSubview(actionsView)
        actionsView.image = screenShot
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        actionsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        actionsView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        actionsView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUpAppereance() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
    
    func setUpGestures() {
        
        actionsView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        actionsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        actionsView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        actionsView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        actionsView.addGestureRecognizer(tap)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
        actionsView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleTap() {
        self.delegate?.widgetViewDidTapped(self.dataSource ?? "datasource")
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: self.frame.size.width + 20, y: 0)
            self.alpha = 0
        }) { (_) in
            //  self.removeFromSuperview()
            self.delegate?.widgetDidSwipped()
        }
    }
}
