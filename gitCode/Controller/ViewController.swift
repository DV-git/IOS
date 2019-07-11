//
//  ViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 6/25/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
class ViewController: UIViewController{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func bitcoinPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBitcoinApp"
            , sender: self)
    }
    
    @IBAction func weatherPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toWeatherApp", sender: self)
    }
    
    @IBAction func chatPressed(_ sender: Any) {
        performSegue(withIdentifier: "toChatApp", sender: self)
    }
    //Mark: -Picker View Methods
    
}


