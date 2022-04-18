//
//  Transaction.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import Foundation

class Transaction{
    var id: Int = 0
    var sender: String
    var recipient: String
    var money: Int
    var date: String
    
    init(sender: String, recipient: String, money: Int, date: Date){
        self.sender = sender
        self.recipient = recipient
        self.money = money
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        self.date = dateFormatter.string(from: date)
    }
    
    init(sender: String, recipient: String, money: Int, date: String){
        self.sender = sender
        self.recipient = recipient
        self.money = money
        self.date = date
        
    }
}
