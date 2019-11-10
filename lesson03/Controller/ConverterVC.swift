//
//  ConverterVC.swift
//  lesson03
//
//  Created by Aidana Imangozhina on 10/12/19.
//  Copyright © 2019 Aidana Imangozhina. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ConverterVC : UIViewController {
    
    @IBOutlet var fromTF: UITextField!
    @IBOutlet var resLabel: UILabel!
    @IBOutlet var howMuchTF: UITextField!
    @IBOutlet var toTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func convertButton(_ sender: Any) {
        if let from = fromTF.text {
            if let to = toTF.text {
                if let howMuch = howMuchTF.text {
                    
                    let converter = Converter(nm: to, price: findFromDb1(from: to))
                    var res = converter.convert(n: Float(howMuch) ?? 0, convertQuote: findFromDb2(to: from))
                    print(res)
                    resLabel.text = String(res)
                }
            }
        }
    }
    
    
    func findFromDb1(from: String) -> String {
        do {
            let realm = try Realm()
            let realmQuotes = realm.objects(Quote.self)
            for i in realmQuotes {
                print(i.name)
                if i.name == from {
                    return (i.price_btc) ?? "0"
                }
            }
            print("could not find")
        } catch {
            print("Cant accromplish findFromDb1")
        }
        return ""
    }
    
    func findFromDb2(to: String) -> Quote {
        let defaultQuote = Quote()
        do {
            let realm = try Realm()
            let realmQuotes = realm.objects(Quote.self)
            for i in realmQuotes {
                print(i.name)

                if i.name == to {
                    return i
                }
            }
            print("could not find")

        } catch {
            print("Cant accromplish findFromDb2")
        }
        return defaultQuote
    }
}
