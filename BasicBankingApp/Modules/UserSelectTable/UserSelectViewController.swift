//
//  UserSelectViewController.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import UIKit

class UserSelectViewController: UIViewController {
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - vars
    var users = [User]()
    weak var selectedUserDelegate: SelectedUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    


}

// MARK: - Table view delegate
extension UserSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUserDelegate!.showSelectedUser(user: users[indexPath.section])
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - Table view data source
extension UserSelectViewController: UITableViewDataSource {
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
