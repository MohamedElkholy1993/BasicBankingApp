//
//  User.swift
//  BasicBankingApp
//
//  Created by User on 02/04/2022.
//

import Foundation

class User {
    
    var id: Int
    var name: String
    var email: String
    var balance: Int
    
    init(id: Int, name: String, email: String, balance: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.balance = balance
    }
    
    static func createUsers()->[User] {
            
        var users = [User]()
        
        let user1 = User(id: 0, name: "mohamed", email: "mohamed@gmail.com", balance: 1000)
        users.append(user1)
        let user2 = User(id: 1, name: "ahmed", email: "ahmed@gmail.com", balance: 2000)
        users.append(user2)
        let user3 = User(id: 2, name: "mostafa", email: "mostafa@gmail.com", balance: 3000)
        users.append(user3)
        let user4 = User(id: 3, name: "malek", email: "malek@gmail.com", balance: 4000)
        users.append(user4)
        let user5 = User(id: 4, name: "adel", email: "adel@gmail.com", balance: 5000)
        users.append(user5)
        let user6 = User(id: 5, name: "farag", email: "farag@gmail.com", balance: 6000)
        users.append(user6)
        let user7 = User(id: 6, name: "ibrahim", email: "ibrahim@gmail.com", balance: 7000)
        users.append(user7)
        let user8 = User(id: 7, name: "aly", email: "aly@gmail.com", balance: 8000)
        users.append(user8)
        let user9 = User(id: 8, name: "ramadan", email: "ramadan@gmail.com", balance: 9000)
        users.append(user9)
        let user10 = User(id: 9, name: "tarek", email: "tarek@gmail.com", balance: 10000)
        users.append(user10)
        
        return users
        }

}
