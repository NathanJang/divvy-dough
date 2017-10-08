//
//  Trip.swift
//  libDivvyDough
//
//  Created by Jonathan Chan on 2017-10-07.
//  Copyright © 2017 Jonathan Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Trip {

    public let id: Int

    public let currentUserId: Int

    public let name: String

    public let memberNames: [String]

    public var leader: String { return memberNames.first! }

    public let balance: Float

    public let amountSpent: Float

    public let startDate: String

    public let endDate: String

    public struct Member {

        public let id: Int

        public let name: String

        public let balance: Float

        public let amountSpent: Float

    }

    public struct Transaction {

        public let name: String

        public let amount: Float

        public let timestamp: String

        public struct Subtransaction {

            public let from: String

            public let amount: Float

            public init?(json: JSON) {
                guard let from = json["from"].string,
                    let amount = json["amount"].float
                    else { return nil }

                self.from = from
                self.amount = amount
            }

        }

        public let subtransactions: [Subtransaction]?

        public init?(json: JSON) {
            guard let name = json["name"].string,
                let amount = json["amount"].float,
                let timestamp = json["time"].string
                else { return nil }

            self.name = name
            self.amount = amount
            self.timestamp = timestamp

            if let subtransactionsJson = json["sub_transactions"].array {
                self.subtransactions = subtransactionsJson.flatMap { return Subtransaction(json: $0) }
            } else {
                self.subtransactions = nil
            }
        }

    }

    public init?(json: JSON, currentUserId: Int) {
        self.currentUserId = currentUserId

        guard let id = json["id"].int,
            let name = json["trip_name"].string,
            let members = json["members"].array,
            let balance = json["balance"].float,
            let amountSpent = json["amount_spent"].float,
            let startDate = json["start_date"].string,
            let endDate = json["end_date"].string
            else { return nil }

        self.id = id
        self.name = name
        self.balance = balance
        self.amountSpent = amountSpent
        self.startDate = startDate
        self.endDate = endDate

        self.memberNames = members.flatMap { return $0.string }
        guard memberNames.count > 0, memberNames.count == members.count else { return nil }
    }

}
