//
//  Quote.swift
//  lesson03
//
//  Created by Aidana Imangozhina on 9/9/19.
//  Copyright © 2019 Aidana Imangozhina. All rights reserved.
//
import Foundation
import RealmSwift
class Quote :  Object, Decodable {
//    struct Stuff: Codable, Equatable {
//        let one, two, four: String
//
//        private enum CodingKeys : String, CodingKey { case one = "1",  two = "2", four = "4"}
//    }
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var rank = ""
    @objc dynamic var price_usd = ""
    @objc dynamic var price_btc = ""
    @objc dynamic var tf_volume_usd = ""
    @objc dynamic var market_cap_usd = ""
    @objc dynamic var available_supply = ""
//    var total_supply = ""
//    var max_supply = ""
//    var percent_change_1h = ""
    @objc dynamic var percent_change_24h = ""
//    var percent_change_7d = ""
    @objc dynamic var last_updated = ""
    private enum CodingKeys: String, CodingKey {
        case tf_volume_usd = "24h_volume_usd", id = "id", name = "name", symbol = "symbol", rank = "rank", price_usd = "price_usd", price_btc = "price_btc", market_cap_usd = "market_cap_usd", available_supply = "available_supply", percent_change_24h = "percent_change_24h", last_updated = "last_updated"
    }
}
