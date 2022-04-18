//
//  TransactionSQLiteCommands.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import Foundation
import SQLite

class TransactionSQLiteCommands {
    
    static var table = Table("users")
    
    // Expressions
    static let id = Expression<Int>("id")
    static let sender = Expression<String>("sender")
    static let recipient = Expression<String>("recipient")
    static let money = Expression<Int>("money")
    static let date = Expression<String>("date")

    
    // Creating Table
    static func createTable() {
        guard let database = TransactionSQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(sender)
                table.column(recipient)
                table.column(money)
                table.column(date, unique: true)
            })
        } catch {
//            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    static func insertRow(_ transactionValues:Transaction) -> Bool? {
        guard let database = TransactionSQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        do {
            try database.run(table.insert(sender <- transactionValues.sender, recipient <- transactionValues.recipient, money <- transactionValues.money, date <- transactionValues.date))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    // Updating Row
    static func updateRow(_ transactionValues: Transaction) -> Bool? {
        guard let database = TransactionSQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        // Extracts the appropriate user from the table according to the id
        let transaction = table.filter(id == transactionValues.id).limit(1)
        
        do {
            // Update the user's values
            if try database.run(transaction.update(sender <- transactionValues.sender, recipient <- transactionValues.recipient, money <- transactionValues.money, date <- transactionValues.date)) > 0 {
//                print("Updated user")
                return true
            } else {
//                print("Could not update user: user not found")
                return false
            }
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Update row faild: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Updation failed: \(error)")
            return false
        }
    }
    
    // Present Rows
    static func presentRows() -> [Transaction]? {
        guard let database = TransactionSQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        // user Array
        var transactionArray = [Transaction]()
        
        // Sorting data in ascending order by ID
        table = table.order(id.asc)
        
        do {
            for transaction in try database.prepare(table) {
                
                _ = transaction[id]
                let senderValue = transaction[sender]
                let recipientValue = transaction[recipient]
                let moneyValue = transaction[money]
                let dateValue = transaction[date]
                
                // Create object
                let transactionObject = Transaction(sender: senderValue, recipient: recipientValue, money: moneyValue, date: dateValue)
                
                // Add object to an array
                transactionArray.append(transactionObject)
                
                print("id \(transaction[id]), sender: \(transaction[sender]), recipient: \(transaction[recipient]), money: \(transaction[money]), date: \(transaction[date])")
            }
        } catch {
            print("Present row error: \(error)")
        }
        return transactionArray
    }
    
    // Delete Row
    static func deleteRow(userId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            let user = table.filter(id == userId).limit(1)
            try database.run(user.delete())
        } catch {
            print("Delete row error: \(error)")
        }
    }
    
    
}
