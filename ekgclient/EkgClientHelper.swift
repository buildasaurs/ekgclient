//
//  EkgClientHelper.swift
//  ekgclient
//
//  Created by Honza Dvorsky on 05/09/2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import Foundation

let kTokenKey = "ekg.token"

public class EkgClientHelper {
    
    private static func pullStringFromBundle(key: String, bundle: NSBundle) -> String? {
        guard let info = bundle.infoDictionary else {
            return nil
        }
        let appId = info[key] as? String
        return appId
    }
    
    public static func pullAppIdentifierFromBundle(bundle: NSBundle) -> String? {
        return self.pullStringFromBundle("CFBundleIdentifier", bundle: bundle)
    }
    
    public static func pullVersionFromBundle(bundle: NSBundle) -> String? {
        return self.pullStringFromBundle("CFBundleShortVersionString", bundle: bundle)
    }
    
    public static func pullBuildNumberFromBundle(bundle: NSBundle) -> String? {
        return self.pullStringFromBundle("CFBundleVersion", bundle: bundle)
    }
    
    internal static func getLocalToken(userDefaults: NSUserDefaults) -> String {
        //check for an existing token
        if let token = userDefaults.stringForKey(kTokenKey) {
            return token
        }
        //generate a new one
        let newToken = NSUUID().UUIDString
        userDefaults.setObject(newToken, forKey: kTokenKey)
        userDefaults.synchronize()
        return newToken
    }
}
