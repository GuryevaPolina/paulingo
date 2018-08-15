//
//  ViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import CoreGraphics
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    var gradient: CAGradientLayer!
    
    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var signInTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        
        print(AppDelegate.realmManager.allUsers)
        print(AppDelegate.realmManager.currentUser)
        
        if !AppDelegate.username.isEmpty && !AppDelegate.password.isEmpty {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? tabBarController else {return}
            guard let navigator = navigationController else {return}
            navigator.pushViewController(vc, animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func viewInit() {
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)).cgColor, UIColor.init(cgColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)).cgColor]
        gradientView.layer.addSublayer(gradient)
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationVC") as? RegistrationViewController else {return}
        guard let navigator = navigationController else {return}
        navigator.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        gradient.colors = [UIColor.init(cgColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).cgColor, UIColor.init(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor]
        
        if !signInTapped {
            usernameTextField.frame.origin.x -= 300
            view1.frame.origin.x -= 300
            passwordTextField.frame.origin.x += 300
            view2.frame.origin.x += 300
            
            usernameTextField.isHidden = false
            passwordTextField.isHidden = false
            view1.isHidden = false
            view2.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.usernameTextField.frame.origin.x += 300
                self.view1.frame.origin.x += 300
                self.passwordTextField.frame.origin.x -= 300
                self.view2.frame.origin.x -= 300
                self.singInButton.frame.origin.y -= 200
            }
            signInTapped = true
            
        } else {
            
            guard let username = usernameTextField.text, !username.isEmpty else {return}
            guard let password = passwordTextField.text, !password.isEmpty else {return}
            
            for user in AppDelegate.realmManager.allUsers {
                if user.username == username && user.password == password {
                    let currUser = CurrentUser()
                    currUser.username = username
                    currUser.password = password
                    
                    try! AppDelegate.realmManager.realm.write {
                        AppDelegate.realmManager.realm.add(currUser)
                    }
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? tabBarController else {return}
                    guard let navigator = navigationController else {return}
                    navigator.pushViewController(vc, animated: true)
                    return
                }
            }
            let alert = UIAlertController(title: "This user isn't exist!", message: "Username or password is uncorrect", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}








