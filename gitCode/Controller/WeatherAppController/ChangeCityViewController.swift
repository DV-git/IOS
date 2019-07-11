//
//  ChangeCityViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/7/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
protocol changeCityDelegate
{
    func userEnteredNewCity(city: String)
}
class ChangeCityViewController: UIViewController {
  
    @IBOutlet weak var changeCity: UITextField!
    
    
    var delegate : changeCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func getWeatherPressed(_ sender: UIButton) {
        
        let cityText = changeCity.text!
        delegate?.userEnteredNewCity(city: cityText)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
