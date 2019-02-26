//
//  MainViewController.swift
//  Langgan-ios
//
//  Created by pramesthi on 10/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation

class MainViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        if (DataAccess.IsNotLoggedIn())
        {
            handleLogout()
        }
    
    }
    
    @objc func handleLogout() {
        self.defaults.set(nil, forKey: "user")
        
        let loginControlller = LoginViewController()
        present(loginControlller, animated: true, completion: nil)
    }
    
}
