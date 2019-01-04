//
//  MessageDetailsVC.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/29/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

protocol MessageDetailsVCDelegate: class {
    func setHelperToolViewWith(dataSource: String, screenShot: UIImage?)
}

class MessageDetailsVC: MainVC {
    
    lazy var button: UIButton = {
        let b = UIButton()
       // b.backgroundColor = .white
       // b.layer.cornerRadius = 22
        b.layer.masksToBounds = true
        b.setTitle("X", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return b
    }()
    
    let textView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var dataSource: String {
        return "I stumbled up both of these repositories while refactoring versions of these apps from TeamTreehouse.com.  As a TeamTreehouse.com student/customer, I really like their approach to abstracting objects in Swift into smaller source code files the lend themselves better toward reusability.  So, after I completed their courses for their Stormy, iTunesClient, and RestaurantReviews apps, I attempted over the last several days to refactor their source code so that the Swift implementations of REST APIs for DarkSky, iTunes, and Yelp use TeamTreehouse.com's Swift protocols while conforming the API result objects to Codable.  I was able to do this successfully for Stormy but found it challenging for iTunesClient because the Album class includes a property of type UIImage.  You appear to have done that successfully for iTunesClient.  Thank you for the time and effort you spent on that.  You’re saving me time and training me through your source code."
    }
    
    weak var delegate: MessageDetailsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavItems(type: .pin, title: "Details", leftSelector:#selector(popBack), rightSelector:#selector(popBackWithHelperView))
        
        view.addSubview(textView)
        
        var constant: CGFloat = 20
        if self.navigationController == nil {
            let helperView = UIView()
            helperView.backgroundColor = #colorLiteral(red: 0.6275901198, green: 0.4403616786, blue: 0.9657108188, alpha: 1)
            constant += 64.0
            view.addSubview(helperView)

            helperView.translatesAutoresizingMaskIntoConstraints = false
            helperView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            helperView.heightAnchor.constraint(equalToConstant: constant).isActive = true
            
            helperView.addSubview(button)
            button.widthAnchor.constraint(equalToConstant: 44).isActive = true
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.leadingAnchor.constraint(equalTo: helperView.leadingAnchor, constant: 20).isActive = true
            button.bottomAnchor.constraint(equalTo: helperView.bottomAnchor, constant: -10).isActive = true
        }
        
        textView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: constant).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        textView.insertText(dataSource)
    }

    @objc func dismissView() {
        textView.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @objc private func popBackWithHelperView() {
        
        self.takeScreenshot { screenShot in
            self.delegate?.setHelperToolViewWith(dataSource: self.dataSource, screenShot: screenShot)
            self.popBack()
        }
    }
    
    @objc private func popBack() {
        self.navigationController?.popViewController(animated: true, completion: {
        })
    }
    
    open func takeScreenshot(with completion: @escaping (UIImage) -> ()) {
        
        DispatchQueue.main.async {
            var screenshotImage : UIImage?
            let layer = UIApplication.shared.keyWindow!.layer
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            guard let context = UIGraphicsGetCurrentContext() else { return }
            layer.render(in:context)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            completion(screenshotImage!)
        }
    }
}

