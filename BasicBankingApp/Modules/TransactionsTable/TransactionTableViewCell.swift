//
//  TransactionTableViewCell.swift
//  BasicBankingApp
//
//  Created by User on 08/04/2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
// MARK: - outlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var recipient: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(transaction: Transaction){
        sender.text = "from:\(transaction.sender)"
        recipient.text = "to:\(transaction.recipient)"
        money.text = "amount:\(transaction.money)$"
        date.text = "date:\(transaction.date)"
        
        container.layer.borderWidth = 3.0
        container.layer.borderColor = UIColor.black.cgColor
        container.backgroundColor = .white
        container.layer.cornerRadius = 20.0
        container.clipsToBounds = true
    }
    
}
