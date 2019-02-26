//
//  BottomNavigationViewController.swift
//  Langgan-ios
//
//  Created by pramesthi on 26/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import UIKit

class BottomNavigationViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        let homeNavController = UINavigationController(rootViewController: MainViewController())
        homeNavController.tabBarItem.title = "Home"
        homeNavController.tabBarItem.image = UIImage(named: "baseline_home_black")
        
        let favViewController = UIViewController()
        let favNavController = UINavigationController(rootViewController: favViewController)
        favNavController.tabBarItem.title = "Favorite"
        favNavController.tabBarItem.image = UIImage(named: "baseline_favorite_black")
        
        let planViewController = UIViewController()
        let planNavController = UINavigationController(rootViewController: planViewController)
        planNavController.tabBarItem.title = "Plan"
        planNavController.tabBarItem.image = UIImage(named: "baseline_subscriptions_black")
        
        let inboxViewController = UIViewController()
        let inboxNavController = UINavigationController(rootViewController: inboxViewController)
        inboxNavController.tabBarItem.title = "Inbox"
        inboxNavController.tabBarItem.image = UIImage(named: "baseline_email_black")
        
        let accountViewController = UIViewController()
        let accountNavController = UINavigationController(rootViewController: accountViewController)
        accountNavController.tabBarItem.title = "Account"
        accountNavController.tabBarItem.image = UIImage(named: "baseline_account_circle_black")
        
        viewControllers = [homeNavController, favNavController, planNavController, inboxNavController, accountNavController]
    }
    
}
