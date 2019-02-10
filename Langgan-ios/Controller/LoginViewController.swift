//
//  LoginViewController.swift
//  Langgan-ios
//
//  Created by pramesthi on 10/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
   
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        var parameters: Parameters?
        let url = "https://tranquil-shore-53254.herokuapp.com/api/users/login"
        
        parameters = ["email": emailText.text!,
                      "password": passwordText.text!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                if (response.result.isSuccess)
                {
                    let responseValue = response.result.value as! NSDictionary
                    if let errorMessage = responseValue["error"]
                    {
                        self.showError(message: errorMessage as! String)
                    }
                    else
                    {
                        let token = responseValue["token"] as! String
                        print("token : \(token)")
                        
                        self.defaults.set(responseValue["data"] as? NSDictionary, forKey: "user")
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.goToMain()
                    }
                }
        }
    }
    
    func showError(message:String)
    {
        print("message : \(message)")
    }
    
}
