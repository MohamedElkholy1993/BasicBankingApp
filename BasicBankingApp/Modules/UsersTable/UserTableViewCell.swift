//
//  UserTableViewCell.swift
//  BasicBankingApp
//
//  Created by User on 02/04/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var container: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(user: User){
        self.nameLabel.text = "Name: \(user.name)"
        self.emailLabel.text = "Email: \(user.email)"
        self.balanceLabel.text = "Balance: \(user.balance) $"
        
        
        container.layer.borderWidth = 3.0
        container.layer.borderColor = UIColor.black.cgColor
        container.backgroundColor = .white
        container.layer.cornerRadius = 20.0
        container.clipsToBounds = true
        
    }
    
}
