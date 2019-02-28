//
//  Vars.swift
//  Langgan-ios
//
//  Created by pramesthi on 28/02/19.
//  Copyright © 2019 Mirza. All rights reserved.
//

import Foundation

public class Vars {
    
    class func getUrl(endPoint: String) -> String {
        let baseUrl = "https://tranquil-shore-53254.herokuapp.com/api/"
        return baseUrl + endPoint
    }
    
}
