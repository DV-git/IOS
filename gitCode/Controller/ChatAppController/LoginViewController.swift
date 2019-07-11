//
//  LoginViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/8/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result,error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                print("Loged in Successfully!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "toChat", sender: self)
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
