//
//  GameViewController.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundGradient: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var dataSource: [Cell] = []
    var game: Game!
    let pixelSize = 10
    let boardWidth = 25
    let boardHeight = 25
    var simulationSpeed: Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundColor()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setGradientBackgroundColor() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.init(named: "AppDark")!.cgColor, UIColor.init(named: "AppLight")!.cgColor ]
        gradientLayer.shouldRasterize = true
        backgroundGradient.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

    }
    
    @IBAction func preset1Tapped(_ sender: UIButton) {
    }
    
    @IBAction func preset2Tapped(_ sender: UIButton) {
    }
    
    @IBAction func preset3Tapped(_ sender: UIButton) {
    }
    
    @IBAction func preset4Tapped(_ sender: UIButton) {
    }
    
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func slowSpeedTapped(_ sender: UIButton) {
    }
    
    @IBAction func mediumSpeedTapped(_ sender: UIButton) {
    }
    
    @IBAction func fastSpeedTapped(_ sender: UIButton) {
    }

}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath) as! GameCollectionViewCell
        cell.configureWithState(dataSource[indexPath.item].isAlive, cellColor: UIColor.blue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pixelSize, height: pixelSize)
    }
}
