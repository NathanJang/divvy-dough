//
//  Networking.swift
//  libDivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public var rootEndpoint: String { return Endpoints.root }

public func setRootEndpoint(_ root: String) {
    Endpoints.root = root
}

struct Endpoints {

    static var root = "http://10.142.8.100:3000/router"

    static var ping: String { return "\(root)/ping" }

    static func allTrips(userId: Int) -> String { return "\(root)/trips/user_id=\(userId)" }

    static func trip(tripId: Int, userId: Int) -> String { return "\(root)/trips/\(tripId)/user_id=\(userId)" }

    static func transactions(tripId: Int, userId: Int) -> String { return "\(root)/trips/\(tripId)/transactions/user_id=\(userId)" }

    struct Leader {

        static func transactions(tripId: Int) -> String { return "\(root)/trips/\(tripId)/leader/transactions" }

        static func balances(tripId: Int) -> String { return "\(root)/trips/\(tripId)/leader/balance" }

    }

    static func deposit(tripId: Int) -> String { return "\(root)/trips/\(tripId)/deposit" }

    static func withdraw(tripId: Int) -> String { return "\(root)/trips/\(tripId)/withdraw" }

}

public enum LibDivvyDoughError: Error {

    case networkError
    case parseError

}

public func ping(completionHandler: @escaping ((_ success: Bool) -> Void)) {
    request(Endpoints.ping).responseString { response in
        completionHandler(response.result.isSuccess)
    }
}

public func getAllTrips(currentUserId: Int, completionHandler: @escaping ((_ trips: [Trip]?, _ pastTrips: [Trip]?, _ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.allTrips(userId: currentUserId)).responseJSON { response in
        guard let rawResult = response.result.value else { return completionHandler(nil, nil, .networkError) }
        let jsonResult = JSON(rawResult)

        guard let tripsJson = jsonResult["trips"].array else { return completionHandler(nil, nil, .parseError) }

        var trips = [Trip]()
        for tripJson in tripsJson {
            guard let trip = Trip(json: tripJson, currentUserId: currentUserId) else { return completionHandler(nil, nil, .parseError) }
            trips.append(trip)
        }

        var pastTrips: [Trip]?
        if let pastTripsJson = jsonResult["past_trips"].array {
            pastTrips = []
            for tripJson in pastTripsJson {
                guard let trip = Trip(json: tripJson, currentUserId: currentUserId) else { continue }
                pastTrips!.append(trip)
            }
        }

        completionHandler(trips, pastTrips, nil)

    }
}

public func getTrip(tripId: Int, userId: Int, completionHandler: @escaping ((_ trip: Trip?, _ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.trip(tripId: tripId, userId: userId)).responseJSON { response in
        guard let rawResult = response.result.value else { return completionHandler(nil, .networkError) }

        let tripJson = JSON(rawResult)
        guard let trip = Trip(json: tripJson, currentUserId: userId) else { return completionHandler(nil, .parseError) }

        completionHandler(trip, nil)
    }
}

public func getTransactions(tripId: Int, userId: Int, completionHandler: @escaping ((_ transactions: [Trip.Transaction]?, _ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.transactions(tripId: tripId, userId: userId)).responseJSON { response in
        guard let rawResult = response.result.value else { return completionHandler(nil, .networkError) }

        guard let transactionsJson = JSON(rawResult).array else { return completionHandler(nil, .parseError) }

        var transactions = [Trip.Transaction]()
        for transactionJson in transactionsJson {
            guard let transaction = Trip.Transaction(json: transactionJson) else { return completionHandler(nil, .parseError) }
            transactions.append(transaction)
        }

        completionHandler(transactions, nil)
    }
}

public func getLeaderTransactions(tripId: Int, completionHandler: @escaping ((_ transactions: [Trip.Transaction]?, _ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.Leader.transactions(tripId: tripId)).responseJSON { response in
        guard let rawResult = response.result.value else { return completionHandler(nil, .networkError) }

        guard let transactionsJson = JSON(rawResult).array else { return completionHandler(nil, .parseError) }

        var transactions = [Trip.Transaction]()
        for transactionJson in transactionsJson {
            guard let transaction = Trip.Transaction(json: transactionJson) else { return completionHandler(nil, .parseError) }
            transactions.append(transaction)
        }

        completionHandler(transactions, nil)
    }
}

public func getLeaderBalances(tripId: Int, completionHandler: @escaping ((_ balances: [(String, Float)]?, _ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.Leader.balances(tripId: tripId)).responseJSON { response in
        guard let rawResult = response.result.value else { return completionHandler(nil, .networkError) }

        guard let balancesJson = JSON(rawResult)["list"].array else { return completionHandler(nil, .parseError) }

        var balances = [(String, Float)]()
        for pair in balancesJson {
            guard let name = pair["name"].string, let balance = pair["balance"].float else { return completionHandler(nil, .parseError) }
            balances.append((name, balance))
        }

        completionHandler(balances, nil)
    }
}

public func deposit(tripId: Int, userId: Int, amount: Float, completionHandler: @escaping ((_ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.deposit(tripId: tripId), method: .post, parameters: [
        "user_id": userId,
        "amount": amount
    ], encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
        guard response.result.isSuccess else { return completionHandler(.networkError) }
        completionHandler(nil)
    }
}

public func withdraw(tripId: Int, userId: Int, amount: Float, completionHandler: @escaping ((_ error: LibDivvyDoughError?) -> Void)) {
    request(Endpoints.withdraw(tripId: tripId), method: .post, parameters: [
        "user_id": userId,
        "amount": amount
    ], encoding: URLEncoding.httpBody, headers: nil).responseJSON { response in
        guard response.result.isSuccess else { return completionHandler(.networkError) }
        completionHandler(nil)
    }
}
