//
//  SettingsViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func exitButtonTapped(_ sender: Any) {
        let currUser = CurrentUser()
        currUser.username = AppDelegate.username
        currUser.password = AppDelegate.password
        
        try! AppDelegate.realmManager.realm.write {
            AppDelegate.realmManager.realm.delete(AppDelegate.realmManager.currentUser[0])
        }
        guard let navigator = navigationController else {return}
        navigator.popViewController(animated: true)
    }
}
