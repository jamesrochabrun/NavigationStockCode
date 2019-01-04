//
//  ViewController.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

class ComposeVC: UIViewController, NavItemType {
    
    lazy var button: UIButton = {
        let b = UIButton()
        b.backgroundColor = .white
        b.layer.cornerRadius = 22
        b.layer.masksToBounds = true
        b.setTitle("X", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return b
    }()
    
    let textView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.setUpNavItems(type: .standard, leftSelector: #selector(handleTapLeft), rightSelector: #selector(handleTapRight))
        //self.navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white//Colors.mainColor
        view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        setDummyTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    private func setDummyTextView() {
        
        let tV = UILabel(frame: CGRect.zero)
        tV.translatesAutoresizingMaskIntoConstraints = false
        tV.text = "To:"
        
        let tVFrom = UILabel(frame: CGRect.zero)
        tVFrom.translatesAutoresizingMaskIntoConstraints = false
        tVFrom.text = "From: james@yahoo.com"
        
        let tVSubject = UILabel(frame: CGRect.zero)
        tVSubject.translatesAutoresizingMaskIntoConstraints = false
        tVSubject.text = "Subject"
        
        let sView = UIStackView(arrangedSubviews: [tV, tVFrom, tVSubject])
        
        self.view.addSubview(sView)
        
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .vertical
        sView.distribution = .fillEqually
        
        sView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        sView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        sView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        sView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        
        let separatorLine = UIView()
        self.view.addSubview(separatorLine)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        separatorLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: sView.bottomAnchor).isActive = true
        
        self.view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: sView.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    @objc func dismissView() {
        textView.resignFirstResponder()
        dismiss(animated: true)
    }
    
    
    @objc func handleTapLeft() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapRight() {
        print("right")
    }
}

