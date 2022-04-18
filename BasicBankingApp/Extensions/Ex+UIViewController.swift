//
//  Ex+UIView.swift
//  BasicBankingApp
//
//  Created by User on 04/04/2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func showAlert(withTitle title: String, andWithMessage message:String,completion: ((UIAlertAction)->(Void))?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: completion)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
//    func showAlertAndDi(withTitle title: String, andWithMessage message:String,completion: ((UIAlertAction)->(Void))?){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: completion)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
}
