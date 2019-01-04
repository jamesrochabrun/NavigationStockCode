//
//  HomeVC.swift
//  NavigationStockCode
//
//  Created by James Rochabrun on 12/27/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

struct Colors {
    static let mainColor = #colorLiteral(red: 0.9294117647, green: 0.2431372549, blue: 0.6470588235, alpha: 1)
    static let subColor = #colorLiteral(red: 0.9960784314, green: 0.7803921569, blue: 0.4235294118, alpha: 1)
    static let textcolor = UIColor.white
}

// This class is just to help customize all the rootcontrollers
class MainVC: UIViewController, NavItemType {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}

class HomeVC: MainVC {
    
    var widgetView: WidgetView?
    
    let circularTransition: CircularTransition = CircularTransition()
    let squareTransition: SquareTransition = SquareTransition()
    
    lazy var composeCircularButton: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(#imageLiteral(resourceName: "compose"), for: .normal)
        b.setTitleColor(Colors.textcolor, for: .normal)
        b.layer.cornerRadius = 35
        b.layer.masksToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(setTheDelegate), for: .touchUpInside)
        return b
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let overlayView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.isHidden = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavItems(type: .standard, leftSelector: #selector(handleTap), rightSelector: #selector(handlePush))
        self.hideRightItem()
//        self.tabBarController?.tabBar.isHidden = true
       // self.navigationController?.navigationBar.isHidden = true
        
        let customNav = self.navigationController as? CustomNavigationController
        let deltaY = customNav?.heightCustomView ?? 0
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: deltaY).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        view.addSubview(overlayView)
        
        view.addSubview(composeCircularButton)
        composeCircularButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        composeCircularButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        composeCircularButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        composeCircularButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        widgetView == nil ? self.hideRightItem() : self.showRightItem()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        overlayView.frame = tableView.frame
    }
    
    @objc func setTheDelegate() {
        
        let secondVC = ComposeVC()
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true)
    }
    
    @objc func handlePush() {
        let vc = ContactsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTap() {
        
    }
}

extension HomeVC: UIViewControllerTransitioningDelegate {
    
    // Delegate transition
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.overlayView.isHidden = false
        self.overlayView.alpha = 0
        UIView.animate(withDuration: circularTransition.duration, animations: {
            self.overlayView.alpha = 0.7
        }) { (_) in
           // self.overlayView.isHidden = true
        }
        
        if let widget = self.widgetView {
            squareTransition.transitionMode = .present
            let ox = self.view.frame.width - self.view.frame.width * 0.2 / 2 - 20
            squareTransition.startingPoint = CGPoint(x: ox, y: widget.center.y + self.topbarHeight)
            squareTransition.circleColor = .white
        }
        
        circularTransition.transitionMode = .present
        circularTransition.startingPoint = CGPoint(x: composeCircularButton.center.x, y: composeCircularButton.center.y + self.topbarHeight)
        
        UIView.animate(withDuration: circularTransition.duration, animations: {
            self.circularTransition.circleColor = .white//#colorLiteral(red: 0.3490196078, green: 0.6784313725, blue: 0.5725490196, alpha: 1)//button.backgroundColor!
        }) { (_) in
        }
        
        if presented is ComposeVC {
            return circularTransition
        }
        return squareTransition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        UIView.animate(withDuration: circularTransition.duration, animations: {
            self.overlayView.alpha = 0
        }) { (_) in
             self.overlayView.isHidden = true
        }
        
        if let widget = self.widgetView {
            squareTransition.transitionMode = .dismiss
            let ox = self.view.frame.width - self.view.frame.width * 0.2 / 2 - 20
            squareTransition.startingPoint = CGPoint(x: ox, y: widget.center.y + self.topbarHeight)
            squareTransition.circleColor = .white
        }
        
        circularTransition.transitionMode = .dismiss
        circularTransition.startingPoint = CGPoint(x: composeCircularButton.center.x, y: composeCircularButton.center.y + self.topbarHeight)
        UIView.animate(withDuration: circularTransition.duration, animations: {
            self.circularTransition.circleColor = .white//button.backgroundColor!
        }) { (_) in
        }
        if dismissed is ComposeVC {
            return circularTransition
        }
        return squareTransition
    }
}

extension HomeVC: MessageDetailsVCDelegate, WidgetViewDelegate {

    func setHelperToolViewWith(dataSource: String, screenShot: UIImage?) {
        
        if widgetView?.isDescendant(of: self.view) ?? false {
            self.widgetView?.removeFromSuperview()
            self.widgetView = nil
        }
        
        widgetView = WidgetView(dataSource: dataSource, screenShot: screenShot!)
        widgetView?.delegate = self
        widgetView?.alpha = 0
        widgetView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSafeSubView(widgetView)
        
        
        let widgetViewwidth = self.view.frame.width * 0.2
        self.widgetView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        self.widgetView?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        self.widgetView?.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.widgetView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        
        self.composeCircularButton.isHidden = true
        self.composeCircularButton.alpha = 0
        self.composeCircularButton.transform = CGAffineTransform(translationX: 100, y: 0)

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 07, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.widgetView?.alpha = 1
            self.showRightItem()
            
            let rightPadding: CGFloat = 20.0
            let tX = widgetViewwidth + rightPadding
            
            // remmeber how we calculate this....
            // let ox = self.view.frame.width - widgetViewwidth / 2 - 20
            self.widgetView?.transform = CGAffineTransform(translationX: -tX, y: 0)
        })
    }
    
    
    func widgetViewDidTapped(_ dataSource: String) {
        
        let detailVC = MessageDetailsVC()
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .custom
        present(detailVC, animated: true)
    }
    
    func widgetDidSwipped() {
        
        self.composeCircularButton.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.composeCircularButton.alpha = 1
            self.composeCircularButton.transform = .identity
            self.hideRightItem()
        }) { (_) in
            //self.widgetView?.removeFromSuperview()
        }
        
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "k")
        cell.textLabel?.text = "Hello are you here?"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MessageDetailsVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class DealsVC: MainVC {}
class DashBoardVC: MainVC {}
class FlightsVC: MainVC {}
class PeopleVC: MainVC {}
class PhotosVC: MainVC {}
