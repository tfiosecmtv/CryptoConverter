//
//  QuoteDetailViewController.swift
//  lesson03
//
//  Created by Aidana Imangozhina on 9/9/19.
//  Copyright © 2019 Aidana Imangozhina. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    var quote: Quote?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var priceUsdLabel: UILabel!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var marketLabel: UILabel!
    @IBOutlet var avsupLabel: UILabel!
    @IBOutlet var perchangeLabel: UILabel!
    @IBOutlet var updateLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date() //not efficient, call it during the execution of the program only once
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        self.title = quote?.name //a title of the VC
        nameLabel.text = quote?.name
        symbolLabel.text = quote?.symbol
        rankLabel.text = quote?.rank
        avsupLabel.text = quote?.available_supply
        marketLabel.text = quote?.market_cap_usd
        perchangeLabel.text=quote?.percent_change_24h
        priceUsdLabel.text=quote?.price_usd
        volumeLabel.text=quote?.tf_volume_usd
        updateLabel.text=result
        // Do any additional setup after loading the view.
    }

}
