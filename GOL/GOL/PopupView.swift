//
//  PopupView.swift
//  GOL
//
//  Created by Fabiola S on 10/21/20.
//

import UIKit

class PopupView: UIView {
    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform:  nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 15
        
        layer.cornerRadius = 15
    }
}
