//
//  CustomButton.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform:  nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 15
        
        layer.cornerRadius = 15
    }
}
