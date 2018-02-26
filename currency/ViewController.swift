//
//  ViewController.swift
//  currency
//
//  Created by Hameleonlab on 26.02.18.
//  Copyright © 2018 hameleonlab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var curTableView: UITableView!
    
    // массив с данными по валютам
    var curData: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrency()
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.fetchCurrency), userInfo: nil, repeats: true)
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        
        fetchCurrency()
    }
    
    
    /**
     получение данных о валютах
     */
    @objc func fetchCurrency() {
        
        // покажем индикатор загрузки
        AppHelper.showActivityIndicator(view: self.view, withOpaqueOverlay: true)
        
        let url = NSURL(string: "http://phisix-api3.appspot.com/stocks.json")
        URLSession.shared.dataTask(with: url! as URL) {(data, response, error) in
            
            // убъем все данные о валютах
            self.curData = []
            
            if error != nil {
                print(error!)
                return
            }

            // и наполним новыми данными
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let stock = (json as! [String: AnyObject])["stock"]
                
                for cur in stock as! [[String: AnyObject]] {
                    
                    let price = cur["price"] as! [String: AnyObject]
                    self.curData.append(Currency(name: cur["name"] as! String, volume: cur["volume"] as! Int, amount: price["amount"] as! Double))
                }
                
                // обновим таблицу и спрячем индикатор
                DispatchQueue.main.async(execute: {
                    
                    self.curTableView.reloadData()
                    AppHelper.hideActivityIndicator(view: self.view)
                })
            } catch let jsonError {
                // выведем ошибку в консоль и спрячем индикатор
                print(jsonError)
                AppHelper.hideActivityIndicator(view: self.view)
            }

        }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return curData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = curTableView.dequeueReusableCell(withIdentifier: "curTableCell", for: indexPath ) as! CurTableViewCell

        cell.nameLabel.text = curData[indexPath.row].curName
        cell.volumeLabel.text = String(curData[indexPath.row].curVolume)
        cell.amountLabel.text = String(format:"%.2f", curData[indexPath.row].curAmount)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

