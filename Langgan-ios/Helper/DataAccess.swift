//
//  DataAccess.swift
//  Langgan-ios
//
//  Created by Mirza on 10/02/19.
//  Copyright © 2019 Mirza. All rights reserved.
//

import Foundation

public class DataAccess {
    
    class func GetUser()-> NSDictionary?{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "user") as? NSDictionary
    }
    
    class func IsNotLoggedIn()-> Bool{
        if (GetUser() == nil)
        {
            return true
        }
        return false
    }
    
}
