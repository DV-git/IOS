//
//  BitcoinViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/6/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class BitcoinViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var selectedCurrencySymbol = ""
    var price: String?
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        updateUIBitcoin()
        // Do any additional setup after loading the view.
    }
    

    // Mark: -DataPicker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let realURL = baseURL + currencyArray[row]
        print(realURL)
        selectedCurrencySymbol = currencySymbolArray[row]
        getBitcoinData(url: realURL)
    }
    
    //Mark: - Networking
    
    
    func getBitcoinData(url: String)
    {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if response.result.isSuccess
            {
                print("Bitcoin Successfull ->getting data")
                let bitcoinJSON : JSON = JSON(response.result.value!)
                self.bitcoinUpdateData(json: bitcoinJSON)
            }
            else
            {
                print("Error->", response.error as Any)
                self.bitcoinPriceLabel.text = "Connection issues"
            
            }
            
        }
    }
    
    //Mark: -JSON PARSING
    func bitcoinUpdateData(json : JSON)
    {
        if let tmpJSON = json["ask"].double
        {
        bitcoinPriceLabel.text = "\(selectedCurrencySymbol)\(String(tmpJSON))"
        }
    else
    {
        bitcoinPriceLabel.text = "Data unavailable"
    }
}
    
    func updateUIBitcoin()
    {
        bitcoinPriceLabel.text = price
    }
}
