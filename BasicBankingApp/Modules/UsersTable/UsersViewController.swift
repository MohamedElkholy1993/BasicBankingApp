//
//  UsersViewController.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import UIKit

class UsersViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    var users = [User](){
        didSet{
            tableView.reloadData()
        }
    }
    var selectedUser: User!
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Home"
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        createTable(users: User.createUsers())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let users = SQLiteCommands.presentRows(){
            self.users = users
        }else{
            self.users = []
        }
        
    }
    
    // MARK: - Database
    private func createTable(users: [User]){
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
        
        for user in users{
            createNewUser(user)
        }
        
        
    }
    
    private func createNewUser(_ userValues:User) {
        let userAddedToTable = SQLiteCommands.insertRow(userValues)
        
        // email is unique to each user so we check if it already exists
        if userAddedToTable == true {
//            print("User Added")
        }
    }

}
// MARK: - Table view delegate
extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUser = users[indexPath.section]

        let storyboard = UIStoryboard(name: "UserDetailsViewController", bundle: nil)
        let userDetailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailsVC.senderUser = selectedUser
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
    
}
// MARK: - Table view data source
extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return users.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell

        cell.configureCell(user: users[indexPath.section])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    
    
}
