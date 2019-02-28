//
//  LoginViewController.swift
//  Langgan-ios
//
//  Created by Mirza on 10/02/19.
//  Copyright © 2019 Mirza. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        return tf
    }()
    
    let emailSeparator: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        
        setupInputsContainerView()
        setupLoginButton()
    }
    
    func setupInputsContainerView() {
        // need x, y, width, height constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparator)
        inputsContainerView.addSubview(passwordTextField)
        
        // need x, y, width, height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        // need x, y, width, height constraints
        emailSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // need x, y, width, height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupLoginButton() {
        // need x, y, width, height constraints
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showError(message:String)
    {
        print("message : \(message)")
    }
    
    @objc func handleLogin() {
        print("token")
        print("email \(emailTextField.text!)")
        print("pass \(passwordTextField.text!)")
        var parameters: Parameters?
        let url = "https://tranquil-shore-53254.herokuapp.com/api/users/login"
        
        parameters = ["email": emailTextField.text!,
                      "password": passwordTextField.text!
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
                        let auth = Auth()
                        auth.auth = responseValue["auth"] as? Bool
                        auth.expiresIn = responseValue["expiresIn"] as? Int
                        auth.token = responseValue["token"] as? String
                        
                        print("auth \(String(describing: auth.auth)) \(String(describing: auth.expiresIn)) \(String(describing: auth.token))")
                        
                        let data = responseValue["data"] as! NSDictionary
                        let user = User()
                        user._id = data["_id"] as? String
                        user.email = data["email"] as? String
                        user.first_name = data["first_name"] as? String
                        user.last_name = data["last_name"] as? String
                        user.updated_at = data["updated_at"] as? String
                        
                        print("user \(String(describing: user._id)) \(String(describing: user.email)) \(String(describing: user.first_name)) \(String(describing: user.last_name))")
                        
                        self.defaults.set(responseValue["data"] as? NSDictionary, forKey: "user")
                        self.defaults.set(responseValue, forKey: "auth")
                        self.defaults.set(auth.token, forKey: "token")
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
        }
    }
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
