//
//  TransactionSQLite.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import Foundation
import SQLite

class TransactionSQLiteDatabase {
    static let sharedInstance = TransactionSQLiteDatabase()
    
    var database: Connection?
    
    private init() {
        // Create connection to database
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("transactionList").appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
        } catch {
//            print("Creating connection to database error: \(error)")
        }
    }
    
    // Creating Table
    func createTable() {
        TransactionSQLiteCommands.createTable()
    }
}
