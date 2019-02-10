//
//  MainViewController.swift
//  Langgan-ios
//
//  Created by pramesthi on 10/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("viewDidUpload")
        
        let defaults = UserDefaults.standard
        let user = defaults.object(forKey: "user") as? NSDictionary
        let email = user!["email"] as! String
        print("user : \(email)")
        
        text.text = email
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("viewDidAppear")
    }
    
}
