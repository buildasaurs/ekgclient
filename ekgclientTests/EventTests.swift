//
//  EventTests.swift
//  ekgclient
//
//  Created by Honza Dvorsky on 05/09/2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import XCTest
@testable import ekgclient

class EventTests: XCTestCase {
    
    func testHeartbeatEvent_Creation() {
        let event = HeartbeatEvent(uptime: 10)
        XCTAssertEqual(event.eventType, "heartbeat")
        XCTAssertEqual(event.uptime, 10)
    }
}
