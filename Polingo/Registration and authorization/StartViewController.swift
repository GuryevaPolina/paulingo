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
        
        //print(AppDelegate.realmManager.allUsers)
       // print(AppDelegate.realmManager.currentUser)
        
        if !AppDelegate.username.isEmpty && !AppDelegate.password.isEmpty {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else {return}
            guard let navigator = navigationController else {return}
            navigator.pushViewController(vc, animated: true)
        }
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func viewInit() {
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.init(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor, UIColor.init(cgColor: #colorLiteral(red: 0.2536556089, green: 0.4862745106, blue: 0.4094202603, alpha: 1)).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registrationVC") as? RegistrationViewController else {return}
        guard let navigator = navigationController else {return}
        navigator.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        gradient.colors = [UIColor.init(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor, UIColor.init(cgColor: #colorLiteral(red: 0.7372432266, green: 0.9486632664, blue: 1, alpha: 1)).cgColor, UIColor.init(cgColor: #colorLiteral(red: 0.3057607528, green: 0.7024124894, blue: 0.5779096659, alpha: 1)).cgColor]
        
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
                //self.singInButton.frame.origin.y = self.view2.frame.origin.y + 32
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
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else {return}
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

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case usernameTextField.tag:
            passwordTextField.becomeFirstResponder()
        case passwordTextField.tag:
            signInButtonTapped(UIButton())
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}








