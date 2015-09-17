//
//  ekgclientTests.swift
//  ekgclientTests
//
//  Created by Honza Dvorsky on 05/09/2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import XCTest
@testable import ekgclient

class ekgclientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        Event.testGenerated = true
    }
    
    func testLive_Sending() {
        let exp = self.expectationWithDescription("network")
        
        let appInfo = AppInfo(appIdentifier: "com.dummy", version: "1.0.yo", build: "1234")
        let serverInfo = ServerInfo(host: NSURL(string: "http://localhost:3000")!)
        let client = EkgClient(appInfo: appInfo, serverInfo: serverInfo)
        
        let event = HeartbeatEvent(uptime: 10)
        
        client.sendEvent(event) { (error) -> () in
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(60, handler: nil)
    }

}
