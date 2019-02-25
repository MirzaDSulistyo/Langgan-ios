//
//  MainViewController.swift
//  Langgan-ios
//
//  Created by pramesthi on 10/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation

class MainViewController: UIViewController {
    
    @IBOutlet weak var text: UITextView!
    
    let bottomNavBar = MDCBottomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("viewDidUpload")
        
        let defaults = UserDefaults.standard
        let user = defaults.object(forKey: "user") as? NSDictionary
        let email = user!["email"] as! String
        print("user : \(email)")
        
        text.text = email
        
        // Always show bottom navigation bar item titles.
//        bottomNavBar.titleVisibility = .always
//
//        // Cluster and center the bottom navigation bar items.
//        bottomNavBar.alignment = .centered
//
//        // Add items to the bottom navigation bar.
//        let tabBarItem1 = UITabBarItem( title: "Status",   image: nil, tag: 0 )
//        let tabBarItem2 = UITabBarItem( title: "Events",   image: nil, tag: 1 )
//        let tabBarItem3 = UITabBarItem( title: "Contacts", image: nil, tag: 2 )
//        bottomNavBar.items = [ tabBarItem1, tabBarItem2, tabBarItem3 ]
//
//        // Select a bottom navigation bar item.
//        bottomNavBar.selectedItem = tabBarItem1;
//
//        view.backgroundColor = .lightGray
//        view.addSubview(bottomNavBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("viewDidAppear")
    }
    
}
