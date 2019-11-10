//
//  Converter.swift
//  lesson03
//
//  Created by Aidana Imangozhina on 10/12/19.
//  Copyright © 2019 Aidana Imangozhina. All rights reserved.
//

import Foundation

class Converter: CustomStringConvertible {
    
    var baseQuote = Quote()
    
    init(nm: String, price: String) {
        self.baseQuote.name = nm
        self.baseQuote.price_btc = price
    }
    
    func convert(n: Float, convertQuote: Quote) -> Float {
        let res = n*(Float(convertQuote.price_btc) ?? 0)/(Float(baseQuote.price_btc) ?? 0)
        return res
    }
    
    var description: String {
        return "\(self.baseQuote.name) " + baseQuote.price_btc
    }
    
}
