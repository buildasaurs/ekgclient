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
    public let typesOfRunningSyncers: [String: Int]
    
    public init(uptime: Double, typesOfRunningSyncers: [String: Int]) {
        self.uptime = uptime
        self.typesOfRunningSyncers = typesOfRunningSyncers
        super.init(eventType: "heartbeat")
    }
    
    var numberOfRunningSyncers: Int {
        return self.typesOfRunningSyncers.values.reduce(0, combine: +)
    }
    
    public override func jsonify() -> JSON {
        var dict = super.jsonify()
        dict["uptime"] = self.uptime
        dict["running_syncers"] = self.numberOfRunningSyncers
        dict["running_syncer_types"] = self.typesOfRunningSyncers
        return dict
    }
}

public class LaunchEvent: Event {
    
    public init() {
        super.init(eventType: "launch")
    }
}

public class UpdateEvent: Event {
    
    public init() {
        super.init(eventType: "update")
    }
}
