//
//  QuotesTableViewController.swift
//  lesson03
//
//  Created by Aidana Imangozhina on 9/9/19.
//  Copyright © 2019 Aidana Imangozhina. All rights reserved.
//

// keychain saves info even if app is not on the phone; userdefaults deletes info whenever app is deleted

import UIKit
import Foundation
import SwipeCellKit
import SwiftKeychainWrapper
import RealmSwift

var res = ""

class QuotesTableViewController: UITableViewController {
    var dataSource: [Quote] = []
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromDb()
        let isFirstStart = !UserDefaults.standard.bool(forKey: "alreadyStartedBefore")
        
        if isFirstStart {
            print("First Started!")
            UserDefaults.standard.set(true, forKey: "alreadyStartedBefore")
        }
        
//        KeychainWrapper.standard.set("Jumysbar", forKey: "password")
//        let secretPassword = KeychainWrapper.standard.string(forKey: "password")
//        print("secret password: \(secretPassword)")
        
        
           NotificationCenter.default.addObserver(self, selector: #selector(readFromDb), name: Notification.Name("updateLabel"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("updateLabel"), object: nil)
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
     

    }
    
    
    
    @objc func readFromDb() {
        do {
            let realm = try Realm()
            let realmQuotes = realm.objects(Quote.self)
            realmQuotes.forEach {
                dataSource.append($0)
            }
        } catch {
            print("Cant accomplish readFromDb")
        }
    }
    
    
    
    
    func loadQuoteData() {
        guard let url = URL(string: "https://api.coinmarketcap.com/v1/ticker") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {
            [weak self]
            (data, response, error) in
            if let data = data,
                let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
                self?.dataSource = quotes
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        dataTask.resume()
        
        for i in dataSource {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(i)
                }
            }
            catch {
                print("Quote adding failed")
            }
        }
    }
    
//    @objc func updateTable() {
//        guard let visibleRowsIndexPaths = self.tableView.indexPathsForVisibleRows else {
//            return
//        }
//
//        for indexPath in visibleRowsIndexPaths {
//            if let cell = tableView.cellForRow(at: indexPath) as? QuoteCell {
//
//
//                //self.tableView.reloadRows(at: [indexPath], with: .none)
//            }
//        }
//
//        self.tableView.reloadData()
//    }
   
    
    @objc func updateTimer() {
//        let i = quotesArray.count-1
//        for j in 0...i {
//            let q = Quote()
//            q.name = quotesArray[j]["name"]!
//            q.id = quotesArray[j]["id"]!
//            q.symbol = quotesArray[j]["symbol"]!
//            q.rank = quotesArray[j]["rank"]!
//            q.price_usd = quotesArray[j]["price_usd"]!
//            q.price_btc = quotesArray[j]["price_btc"]!
//            q.tf_volume_usd = quotesArray[j]["24h_volume_usd"]!
//            q.market_cap_usd = quotesArray[j]["market_cap_usd"]!
//            q.available_supply = quotesArray[j]["available_supply"]!
//            q.total_supply = quotesArray[j]["total_supply"]!
//            q.max_supply = quotesArray[j]["max_supply"]!
//            q.percent_change_1h = quotesArray[j]["percent_change_1h"]!
//            q.percent_change_24h = quotesArray[j]["percent_change_24h"]!
//            q.percent_change_7d = quotesArray[j]["percent_change_7d"]!
//            q.last_updated = quotesArray[j]["last_updated"]!
//            quotes.append(q)
//        }
            loadQuoteData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count //count - size of array
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteCell
            let quote = dataSource[indexPath.row]
        cell?.nameLabel.text = quote.name
        cell?.symbolLabel.text = quote.symbol
        cell?.rankLabel.text = quote.rank
            cell?.avsupLabel.text = quote.available_supply
            cell?.marketLabel.text = quote.market_cap_usd
            cell?.perchangeLabel.text=quote.percent_change_24h
        cell?.priceUsdLabel.text=quote.price_usd
        cell?.updateLabel.text = quote.last_updated
            cell?.volumeLabel.text=quote.tf_volume_usd
        //cell?.delegate = self as! SwipeTableViewCellDelegate
            return cell ?? UITableViewCell()
    }

 

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quotesListToDetail" {
            if let cell = sender as? QuoteCell {
                //Если sender - это QuoteCell, то мы перейдем сюда
                if let indexPath = tableView.indexPath(for: cell) {
                    //Получили индекс нажатой ячейки если есть (опционал)
                    let quote = dataSource[indexPath.row]
                    let detailVC = segue.destination as? QuoteDetailViewController
                    detailVC?.quote = quote
                }
                
            }
        }
    }

}
