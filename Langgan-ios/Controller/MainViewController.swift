//
//  MainViewController.swift
//  Langgan-ios
//
//  Created by Mirza on 10/02/19.
//  Copyright © 2019 Mirza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        if (DataAccess.IsNotLoggedIn())
        {
            handleLogout()
        }
        
        let data = defaults.object(forKey: "user") as! NSDictionary
        let user = User()
        user._id = data["_id"] as? String
        user.email = data["email"] as? String
        user.first_name = data["first_name"] as? String
        user.last_name = data["last_name"] as? String
        user.updated_at = data["updated_at"] as? String
        print("user on main \(String(describing: user._id)) \(String(describing: user.email)) \(String(describing: user.first_name)) \(String(describing: user.last_name))")
        
        //let auth = defaults.object(forKey: "auth") as! NSDictionary
        let token = defaults.object(forKey: "token") as! String
        print("token on main \(String(describing: token))")
        
        let url = Vars.getUrl(endPoint: "product")
        print("url \(url)")
        
        getProducts(url: url, token: token)
        
    }
    
    @objc func handleLogout() {
        self.defaults.set(nil, forKey: "user")
        
        let loginControlller = LoginViewController()
        present(loginControlller, animated: true, completion: nil)
    }
    
    func getProducts(url: String, token: String) {
        let headers: HTTPHeaders = [
            "token": token
        ]
        
        Alamofire.request(url, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.isSuccess)
                {
                    print("Success! got the product data")
                    let json : JSON = JSON(response.result.value!)
                    
                    let jsonArray: [JSON] = json["data"].arrayValue
                    for j in jsonArray {
                        let product = Product()
                        product.name = j["name"].string
                        self.products.append(product)
                    }
                    
                    print("products size \(self.products.count)")
                    
                }
                else {
                    print("Error \(String(describing: response.result.error))")
                }
        }
    }
    
}
