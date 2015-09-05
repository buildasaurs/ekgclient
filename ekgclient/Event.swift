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
    
    public let eventType: String
    
    public init(eventType: String) {
        self.eventType = eventType
    }
    
    public func jsonify() -> JSON {
        var dict = JSON()
        dict["test_generated"] = true //to throw it away at the server
        dict["event_type"] = self.eventType
        return dict
    }
}

public class HeartbeatEvent: Event {
    
    public let uptime: Double
    
    public init(uptime: Double) {
        self.uptime = uptime
        super.init(eventType: "heartbeat")
    }
    
    public override func jsonify() -> JSON {
        var dict = super.jsonify()
        dict["uptime"] = self.uptime
        return dict
    }
}

public class LaunchEvent: Event {
    
    public init() {
        super.init(eventType: "launch")
    }
}
