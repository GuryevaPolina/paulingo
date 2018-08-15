//
//  RegistrationViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("registration")
        guard let username = userNameTextField.text, !username.isEmpty else {return}
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}
        
        if password.count < 6 {
            let alert = UIAlertController(title: "Password is too short!", message: "Password must be more then 6 symbols", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        for user in AppDelegate.realmManager.allUsers {
            if user.email == email {
                let alert = UIAlertController(title: "Account already exist!", message: "That email address already have been used", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
                return
            }
            
            if user.username == username {
                let alert = UIAlertController(title: "Username is busy!", message: "Enter another username, please", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
                return
            }
        }
        
        let newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        let currUser = CurrentUser()
        currUser.username = username
        currUser.password = password
        
        try! AppDelegate.realmManager.realm.write {
            AppDelegate.realmManager.realm.add(newUser)
            AppDelegate.realmManager.realm.add(currUser)
        }
        AppDelegate.username = username
        AppDelegate.password = password
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? tabBarController else {return}
        guard let navigator = navigationController else {return}
        navigator.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}






