//
//  TabBarViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 16.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var navBarView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    var learnVC: LearnViewController!
    var settingVC: SettingsViewController!
    
    var selectedIndex: Int = 0
    var previousIndex: Int = 0
    
    @IBOutlet var buttons: [UIButton]!
    var viewControllers: [UIViewController]!
    var selectedButtonsImages: [UIImage] = [#imageLiteral(resourceName: "brain_selected"), #imageLiteral(resourceName: "settings_selected")]
    var buttonImages: [UIImage] = [#imageLiteral(resourceName: "brain"), #imageLiteral(resourceName: "settings")]
    
    var chooseLanguageIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewInit()
    }
    
    func viewInit() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        tabBarView.layer.shadowColor = UIColor.lightGray.cgColor
        tabBarView.layer.shadowOpacity = 1.0
        tabBarView.layer.shadowOffset = .zero
        tabBarView.layer.shadowRadius = 5.0
        
        navBarView.layer.shadowColor = UIColor.lightGray.cgColor
        navBarView.layer.shadowOpacity = 1.0
        navBarView.layer.shadowOffset = .zero
        navBarView.layer.shadowRadius = 3.0
        navBarView.layer.masksToBounds = false
        
        learnVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "learnVC") as! LearnViewController
        settingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingVC") as! SettingsViewController
        
        viewControllers = [learnVC, settingVC]
        
        buttons[selectedIndex].isSelected = true
        tabDidTapped(buttons[selectedIndex])
    }
    
    @IBAction func tabDidTapped(_ sender: UIButton) {
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        buttons[previousIndex].setImage(buttonImages[previousIndex], for: .normal)
        sender.isSelected = true
        sender.setImage(selectedButtonsImages[selectedIndex], for: .normal)
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        let vc = viewControllers[selectedIndex]
        vc.view.frame = contentView.bounds
        vc.didMove(toParentViewController: self)
        addChildViewController(vc)
        contentView.addSubview(vc.view)
    }
    
    @IBAction func chooseLanguageButtonTapped(_ sender: UIButton) {
       
        if let vc = viewControllers[selectedIndex] as? LearnViewController {
            if !chooseLanguageIsOpen {
                vc.moveChooseLanguageView()
                sender.setImage(vc.currLanguageImage, for: .normal)
                chooseLanguageIsOpen = true
            }
        }
        
        
    }
    
}











