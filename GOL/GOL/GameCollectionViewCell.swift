//
//  GameCollectionViewCell.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GameCollectionViewCell"
    let cellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithState(_ isAlive: Bool, cellColor: UIColor) {
        self.cellView.backgroundColor = isAlive ? cellColor : UIColor.lightGray
    }
    
    private func configure() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
