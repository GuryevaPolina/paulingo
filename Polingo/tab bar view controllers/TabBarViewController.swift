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
    
    @IBOutlet weak var brainButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    var tabBarButtons: [UIButton: UIImage] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewInit()
        tabBarButtons = [brainButton: #imageLiteral(resourceName: "brain"), settingButton: #imageLiteral(resourceName: "settings")]
    }
    
    func viewInit() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        tabBarView.layer.shadowColor = UIColor.lightGray.cgColor
        tabBarView.layer.shadowOpacity = 1.0
        tabBarView.layer.shadowOffset = .zero
        tabBarView.layer.shadowRadius = 5.0
    }
    
    func setAnotherButtonIdentity(currentButton: UIButton) {
        for button in tabBarButtons.keys {
            if button != currentButton {
                button.transform = .identity
                button.setImage(tabBarButtons[button], for: .normal)
            }
        }
    }
    
    @IBAction func brainButtonTapped(_ sender: UIButton) {
        setAnotherButtonIdentity(currentButton: sender)
        
        brainButton.setImage(#imageLiteral(resourceName: "brain_selected"), for: .normal)
        brainButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "learnVC") as? LearnViewController else {return}
        guard let navigator = navigationController else {return}
        navigator.setViewControllers([vc], animated: false)
    }
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
        setAnotherButtonIdentity(currentButton: sender)
        
        settingButton.setImage(#imageLiteral(resourceName: "brain_selected"), for: .normal)
        settingButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingVC") as? SettingsViewController else {return}
        guard let navigator = navigationController else {return}
        navigator.setViewControllers([vc], animated: false)
    }
    
    
}
