//
//  ekgclient.swift
//  ekgclient
//
//  Created by Honza Dvorsky on 05/09/2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import Foundation

public struct AppInfo: Sendable {
    
    public let appIdentifier: String
    public let version: String
    public let build: String
}

public class EkgClient {
    
    public static var sharedInstance: EkgClient?
    
    //app info
    public let appInfo: AppInfo
    
    //server info
    public let serverInfo: ServerInfo
    
    //sender
    private let sender: Sender
    
    //persistence
    private let userDefaults: NSUserDefaults
    
    //token
    private var token: String { get { return EkgClientHelper.getLocalToken(self.userDefaults) } }
    
    public init(
        userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults(),
        appInfo: AppInfo,
        serverInfo: ServerInfo
        ) {
            
            self.userDefaults = userDefaults
            self.appInfo = appInfo
            self.serverInfo = serverInfo
            self.sender = SenderFactory.senderFromServerInfo(serverInfo)
    }
    
    public func sendEvent(event: Event, completion: ((error: ErrorType?) -> ())? = nil) {
        
        //take event data
        var combined = event.jsonify()
        
        //combine with app data and token
        let appData = self.appInfo.jsonify()
        combined = combined.merge(appData).merge(["token": self.token])
        
        self.sender.sendEvent(combined, completion: completion)
    }
}

extension Dictionary {
    func merge(other: Dictionary) -> Dictionary {
        var copy = self
        other.forEach { (let key, let value) -> () in
            copy.updateValue(value, forKey: key)
        }
        return copy
    }
}

extension AppInfo {
    public func jsonify() -> JSON {
        var dict = JSON()
        dict["app"] = self.appIdentifier
        dict["version"] = self.version
        dict["build"] = self.build
        return dict
    }
}
