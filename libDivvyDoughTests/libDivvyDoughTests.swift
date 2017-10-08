//
//  libDivvyDoughTests.swift
//  libDivvyDoughTests
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import XCTest
@testable import libDivvyDough

class libDivvyDoughTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPing() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        ping { success in
            XCTAssert(success)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetAllTrips() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        getAllTrips(currentUserId: 1) { trips, pastTrips, error in
            XCTAssertNotNil(trips)
            if let trips = trips { XCTAssertGreaterThan(trips.count, 0) }
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetTrip() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        getTrip(tripId: 0, userId: 0) { trip, error in
            XCTAssertNotNil(trip)
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetTransactions() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        getTransactions(tripId: 1, userId: 1) { transactions, error in
            XCTAssertNotNil(transactions)
            if let transactions = transactions { XCTAssertGreaterThan(transactions.count, 0) }
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetLeaderTransactions() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        getLeaderTransactions(tripId: 1) { transactions, error in
            XCTAssertNotNil(transactions)
            if let transactions = transactions {
                XCTAssertGreaterThan(transactions.count, 0)
                for t in transactions {
                    XCTAssertNotNil(t.subtransactions)
                    if let subtransactions = t.subtransactions { XCTAssertGreaterThan(subtransactions.count, 0) }
                }
            }
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetLeaderBalances() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        getLeaderBalances(tripId: 1) { balances, error in
            XCTAssertNotNil(balances)
            if let balances = balances { XCTAssertGreaterThan(balances.count, 0) }
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testDeposit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        deposit(tripId: 1, userId: 1, amount: 1.18) { error in
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testWithdraw() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let exp = expectation(description: "\(#function)\(#line)")
        withdraw(tripId: 1, userId: 1, amount: 120.33) { error in
            XCTAssertNil(error)
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
