//
//  TransactionsViewController.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import UIKit

class TransactionsViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var transactions = [Transaction](){
        didSet{
            tableView.reloadData()
        }
    }
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Transactions"
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        createTable()
        if let transactions = TransactionSQLiteCommands.presentRows(){
            self.transactions = transactions
        }else{
            self.transactions = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let transactions = TransactionSQLiteCommands.presentRows(){
            self.transactions = transactions
        }else{
            self.transactions = []
        }
        
    }
    
    // MARK: - Database
    private func createTable(){
        let database = TransactionSQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    

}
    
// MARK: - Table view delegate
extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
// MARK: - Table view data source
extension TransactionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return transactions.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell

        cell.configure(transaction: transactions[indexPath.section])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
    
}

