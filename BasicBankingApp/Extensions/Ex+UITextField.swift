//
//  Ex+UITextField.swift
//  BasicBankingApp
//
//  Created by User on 05/04/2022.
//

import Foundation
import UIKit

extension UITextField{
    
    
    func customize(){
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = .lightGray
        self.sizeToFit()
        
    }
    
}
