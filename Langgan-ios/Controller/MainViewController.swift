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
    var token = ""
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Home"
        
        if (DataAccess.IsNotLoggedIn())
        {
            handleLogout()
        }
        
        getUserData()
        
        getToken()
        
        let url = Vars.getUrl(endPoint: "product")
        print("url \(url)")
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        
        getProducts(url: url)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let product = products[indexPath.row]
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.price?.description
        //cell.imageView?.downloaded(from: product.photo!)
        //let url = URL(string: product.photo!)!
        //downloadImage(from: url, to: cell.imageView!)
        cell.imageView?.image = UIImage(named: "type")
        
        //cell.imageView?.downloaded(from: product.photo!)
        
        let url = URL(string: product.photo!)!
        downloadImage(from: url, to: cell.imageView!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func getUserData() {
        let data = defaults.object(forKey: "user") as! NSDictionary
        let user = User()
        user._id = data["_id"] as? String
        user.email = data["email"] as? String
        user.first_name = data["first_name"] as? String
        user.last_name = data["last_name"] as? String
        user.updated_at = data["updated_at"] as? String
        print("user on main \(String(describing: user._id)) \(String(describing: user.email)) \(String(describing: user.first_name)) \(String(describing: user.last_name))")
    }
    
    func getToken() {
        //let auth = defaults.object(forKey: "auth") as! NSDictionary
        token = defaults.object(forKey: "token") as! String
        print("token on main \(String(describing: token))")
    }
    
    @objc func handleLogout() {
        self.defaults.set(nil, forKey: "user")
        
        let loginControlller = LoginViewController()
        present(loginControlller, animated: true, completion: nil)
    }
    
    func getProducts(url: String) {
        let headers: HTTPHeaders = [
            "token": token
        ]
        
        Alamofire.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                if (response.result.isSuccess)
                {
                    if ((response.response?.statusCode)! == 200) {
                        print("Success! got the product data")
                        
                        let json : JSON = JSON(response.result.value!)
                        
                        let jsonArray: [JSON] = json["data"].arrayValue
                        for j in jsonArray {
                            let product = Product()
                            product._id = j["_id"].string
                            product.store_id = j["store_id"].string
                            product.name = j["name"].string
                            product.descriptions = j["description"].string
                            product.photo = j["photo"].string
                            product.brand = j["brand"].string
                            product.barcode = j["barcode"].string
                            product.sku = j["sku"].string
                            product.price = j["price"].int
                            product.created_at = j["created_at"].string
                            product.updated_at = j["updated_at"].string
                            self.products.append(product)
                        }
                        print("products size \(self.products.count)")
                        self.tableView.reloadData()
                    } else {
                        print("Response Error! wih code: \(String(describing: response.response?.statusCode))")
                    }
                    
                }
                else {
                    print("Error \(String(describing: response.result.error))")
                }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, to imageView: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
}

class ProductCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
