//
//  SQLiteCommands.swift
//  BasicBankingApp
//
//  Created by User on 04/04/2022.
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var table = Table("users")
    
    // Expressions
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let email = Expression<String>("email")
    static let balance = Expression<Int>("balance")
    
    // Creating Table
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(email, unique: true)
                table.column(balance)
            })
        } catch {
//            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    static func insertRow(_ userValues:User) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        do {
            try database.run(table.insert(name <- userValues.name, email <- userValues.email, balance <- userValues.balance))
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
    static func updateRow(_ userValues: User) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        // Extracts the appropriate user from the table according to the id
        let user = table.filter(id == userValues.id).limit(1)
        
        do {
            // Update the user's values
            if try database.run(user.update(name <- userValues.name, email <- userValues.email, balance <- userValues.balance)) > 0 {
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
    static func presentRows() -> [User]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return nil
        }
        
        // user Array
        var userArray = [User]()
        
        // Sorting data in ascending order by ID
        table = table.order(id.asc)
        
        do {
            for user in try database.prepare(table) {
                
                let idValue = user[id]
                let nameValue = user[name]
                let emailValue = user[email]
                let balanceValue = user[balance]
                
                
                // Create object
                let userObject = User(id: idValue, name: nameValue, email: emailValue, balance: balanceValue)
                
                // Add object to an array
                userArray.append(userObject)
                
//                print("id \(user[id]), name: \(user[name]), email: \(user[email]), balance: \(user[balance])")
            }
        } catch {
//            print("Present row error: \(error)")
        }
        return userArray
    }
    
    // Delete Row
    static func deleteRow(userId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
//            print("Datastore connection error")
            return
        }
        
        do {
            let user = table.filter(id == userId).limit(1)
            try database.run(user.delete())
        } catch {
//            print("Delete row error: \(error)")
        }
    }
    
    static func presentRows(without user: User) -> [User]{
        var users = [User]()
        if let filteredUsers = presentRows()?.filter({ $0.id != user.id }){
            users = filteredUsers
        }
        return users
        
    }
}
