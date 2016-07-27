//
//  Config.swift
//  ColorSmart
//
//  Created by David on 26/07/16.
//  Copyright © 2016 Behr. All rights reserved.
//

import Foundation

enum Environment: String {
    case Staging = "staging"
    case Production = "production"
    
    var baseURL: String {
        switch self {
        case .Staging: return "http://qa-behr-stg1.udev1b.net/ws/native/v1"
        case .Production: return "http://behr.udev1b.net/ws/native/v1"
        }
    }
    
    var token: String {
        switch self {
        case .Staging: return ""
        case .Production: return ""
        }
    }
}

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = NSBundle.mainBundle().objectForInfoDictionaryKey("Configuration") as? String {
            if configuration.rangeOfString("Staging") != nil {
                return Environment.Staging
            }
        }
        
        return Environment.Production
    }()
}