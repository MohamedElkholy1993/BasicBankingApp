//
//  UserDetailsViewController.swift
//  BasicBankingApp
//
//  Created by User on 03/04/2022.
//

import UIKit

class UserDetailsViewController: UIViewController, UITextFieldDelegate{
    
    

    // MARK: - outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var transferToLabel: UILabel!
    @IBOutlet weak var transferDoneButton: UIButton!
    @IBOutlet weak var transferToButton: UIButton!
    @IBOutlet weak var moneyTF: UITextField!
    
    // MARK: - vars
    var senderUser: User!
    var recipientUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        self.nameLabel.text = "Name: \(senderUser.name)"
        self.nameLabel.customize()
        self.emailLabel.text = "Email: \(senderUser.email)"
        self.emailLabel.customize()
        self.balanceLabel.text = "Balance: \(senderUser.balance) $"
        self.balanceLabel.customize()
        self.transferToButton.customize()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK: - Actions
    @IBAction func transferToButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserSelectStoryboard", bundle: nil)
        let userSelectVC = storyboard.instantiateViewController(withIdentifier: "UserSelectViewController") as! UserSelectViewController
        userSelectVC.users = SQLiteCommands.presentRows(without: senderUser)
        
        userSelectVC.selectedUserDelegate = self
        self.present(userSelectVC, animated: true, completion: nil)
    }
    
    @IBAction func transferDoneButtonTapped(_ sender: Any) {
        if moneyTF.text!.isEmpty{
            showAlert(withTitle: "Attention", andWithMessage: "please enter amount of money", completion: nil)
        }else{
            if let money = Int(moneyTF.text!){
                if senderUser.balance >= money{
                    senderUser.balance -= money
                    recipientUser.balance += money
                    // TODO: - save to DB
                    
                    if (SQLiteCommands.updateRow(senderUser)! && SQLiteCommands.updateRow(recipientUser)!){
                        let newTransaction = Transaction(sender: senderUser.name, recipient: recipientUser.name, money: money, date: Date.now)
                        moneyTF.resignFirstResponder()
                        print(TransactionSQLiteCommands.insertRow(newTransaction)!)
                        showAlert(withTitle: "Attention", andWithMessage: "transaction done successfully"){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }else{
                        showAlert(withTitle: "Attention", andWithMessage: "transaction incomplete", completion: nil)
                    }
                    
                    
                    
                    
                }else{
                    showAlert(withTitle: "Attention", andWithMessage: "balance is not sufficient", completion: nil)
                    moneyTF.text = ""
                }
            }
        }
    }
    
}

extension UserDetailsViewController: SelectedUser{
    
    func showSelectedUser(user: User) {
        recipientUser = user
        transferToLabel.text = "Transfering to \(user.name)"
        transferToLabel.customize()
        transferToLabel.isHidden = false
        moneyTF.isHidden = false
        moneyTF.customize()
        transferToButton.isHidden = true
        transferDoneButton.isHidden = false
        transferDoneButton.customize()
    }
    
}


