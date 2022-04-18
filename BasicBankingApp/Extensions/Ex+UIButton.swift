//
//  Ex+UIButton.swift
//  BasicBankingApp
//
//  Created by User on 05/04/2022.
//

import Foundation
import UIKit

extension UIButton{
    
    func customize(){
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemCyan.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = .white
        self.sizeToFit()
        
    }
    
}
