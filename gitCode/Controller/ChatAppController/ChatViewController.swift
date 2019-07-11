//
//  ChatViewController.swift
//  gitCode
//
//  Created by Dimitar Vitanov on 7/8/19.
//  Copyright © 2019 Dimitar Vitanov. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var messageArray : [Message] = [Message]()
   @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.dataSource = self
        messageTable.delegate = self
        messageTextField.delegate = self
        
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTable.addGestureRecognizer(tapGesture)
        
        //TODO: Register your MessageCell.xib file here:
        messageTable.register(UINib(nibName: "MessageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCellTableViewCell")
        
        configureTableView()
        retriveMessage()
        messageTable.separatorStyle = .none
    }
    

  // Table view functions
    func configureTableView()
    {
        messageTable.rowHeight = UITableView.automaticDimension
        messageTable.estimatedRowHeight = 120.0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellTableViewCell", for: indexPath) as! MessageCellTableViewCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        
        cell.avatarImageView.image = UIImage(named: "icon-63")
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email
        {
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        }
        else
        {
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
        return cell
        
        
        
    }
    
    
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 208
//            self.view.layoutIfNeeded()
//        }
//    }
//
//    //TODO: Declare textFieldDidEndEditing here:
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
//    }
//
//
    ////////////////
    @IBAction func buttonPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        let messageDb = Database.database().reference().child("Messages")
        let messageDictionery = ["Sender": Auth.auth().currentUser?.email, "Message Body": messageTextField.text!]
        messageDb.childByAutoId().setValue(messageDictionery)
        { (error, reference) in
            if error != nil
            {
                print(error!)
            }
            
            else
            {
                print("Message successfully send")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
                
            }
        }
    }
    
    func retriveMessage()
    {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["Message Body"]!
            let sender = snapshotValue["Sender"]!
            print(text,sender)
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTable.reloadData()
        })
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch
        {
            print("There was an error signing out")
        }
    }
}
