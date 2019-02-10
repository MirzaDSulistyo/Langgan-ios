//
//  DataAccess.swift
//  Langgan-ios
//
//  Created by pramesthi on 10/02/19.
//  Copyright © 2019 Olsera. All rights reserved.
//

import Foundation

public class DataAccess {
    
    class func GetUser()-> NSDictionary?{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "user") as? NSDictionary
    }
    
    class func IsLoggedIn()-> Bool{
        if (GetUser() != nil)
        {
            return true
        }
        return false
    }
    
}
