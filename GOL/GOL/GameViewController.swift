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
        game.runPreset1()
    }
    
    @IBAction func preset2Tapped(_ sender: UIButton) {
        game.runPreset2()
    }
    
    @IBAction func preset3Tapped(_ sender: UIButton) {
        game.runPreset3()
    }
    
    @IBAction func preset4Tapped(_ sender: UIButton) {
        game.runPreset4()
    }
    
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        game.clear()
        dataSource.removeAll()
        collectionView.reloadData()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        game = Game(width: boardWidth, height: boardHeight)
        game.start(gameSpeed: simulationSpeed) { [weak self] state in
            self?.display(state)
        }
    }
    
    func display(_ state: GameState) {
        self.dataSource = state.cells
        collectionView.reloadData()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        game.stop()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        game.clear()
        dataSource.removeAll()
        collectionView.reloadData()
    }
    
    @IBAction func slowSpeedTapped(_ sender: UIButton) {
        simulationSpeed = 1.0
        game.start(gameSpeed: simulationSpeed) { [weak self] state in
            self?.display(state)
        }
    }
    
    @IBAction func mediumSpeedTapped(_ sender: UIButton) {
        simulationSpeed = 0.5
        game.start(gameSpeed: simulationSpeed) { [weak self] state in
            self?.display(state)
        }
    }
    
    @IBAction func fastSpeedTapped(_ sender: UIButton) {
        simulationSpeed = 0.33
        game.start(gameSpeed: simulationSpeed) { [weak self] state in
            self?.display(state)
        }
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
