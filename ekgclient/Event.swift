//
//  Event.swift
//  ekgclient
//
//  Created by Honza Dvorsky on 05/09/2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import Foundation

//event types
//https://github.com/czechboy0/ekg/blob/master/routes/utils/events.js#L24

public typealias JSON = [String: AnyObject]
public protocol Sendable {
    func jsonify() -> JSON
}

public class Event: Sendable {
    
    public static var testGenerated = false
    
    public let eventType: String
    
    public init(eventType: String) {
        self.eventType = eventType
    }
    
    public func jsonify() -> JSON {
        var dict = JSON()
        if Event.testGenerated {
            dict["test_generated"] = true //to throw away test events at the server
        }
        dict["event_type"] = self.eventType
        return dict
    }
}

public class HeartbeatEvent: Event {
    
    public let uptime: Double
    public let numberOfRunningSyncers: Int
    
    public init(uptime: Double, numberOfRunningSyncers: Int) {
        self.uptime = uptime
        self.numberOfRunningSyncers = numberOfRunningSyncers
        super.init(eventType: "heartbeat")
    }
    
    public override func jsonify() -> JSON {
        var dict = super.jsonify()
        dict["uptime"] = self.uptime
        dict["running_syncers"] = self.numberOfRunningSyncers
        return dict
    }
}

public class LaunchEvent: Event {
    
    public init() {
        super.init(eventType: "launch")
    }
}
