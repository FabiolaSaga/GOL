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
    @IBOutlet weak var colorsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var preset1: UIButton!
    @IBOutlet weak var preset2: UIButton!
    @IBOutlet weak var preset3: UIButton!
    @IBOutlet weak var preset4: UIButton!
    @IBOutlet weak var generationsLabel: UILabel!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    // MARK: - Properties
    var dataSource: [Cell] = []
    var game: Game!
    let pixelSize = 10
    let boardWidth = 25
    let boardHeight = 25
    var simulationSpeed: Double = 1.0
    var selectedColor: UIColor = .blue
    var firstTimeRunning = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        setColorsForSegmentedControl()
        setButtonState(enabled: false)
        generationsLabel.isHidden = true
    }
    
    func setColorsForSegmentedControl() {
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
    }
    
    func setButtonState(enabled: Bool) {
        preset1.isEnabled = enabled
        preset2.isEnabled = enabled
        preset3.isEnabled = enabled
        preset4.isEnabled = enabled
        randomizeButton.isEnabled = enabled
        stopButton.isEnabled = enabled
        clearButton.isEnabled = enabled
        
        if enabled == false {
            preset1.alpha = 0.5
            preset2.alpha = 0.5
            preset3.alpha = 0.5
            preset4.alpha = 0.5
            randomizeButton.alpha = 0.5
            stopButton.alpha = 0.5
            clearButton.alpha = 0.5
        } else {
            preset1.alpha = 1
            preset2.alpha = 1
            preset3.alpha = 1
            preset4.alpha = 1
            randomizeButton.alpha = 1
            stopButton.alpha = 1
            clearButton.alpha = 1
        }
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
        game.randomize()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        generationsLabel.isHidden = false
        setButtonState(enabled: true)
        game = Game(width: boardWidth, height: boardHeight)
        if firstTimeRunning {
            game.start(gameSpeed: simulationSpeed) { [weak self] state in
                self?.display(state)
            }
        } else {
            game.resume(gameSpeed: simulationSpeed) { [weak self] state in
                self?.display(state)
            }
        }
    
    }
    
    func display(_ state: GameState) {
        self.dataSource = state.cells
        collectionView.reloadData()
        generationsLabel.text = "Generations: \(game.generationCount)"
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        game.stop()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        game.clear()
        generationsLabel.text = "Generations: 0"
        dataSource.removeAll()
        collectionView.reloadData()
    }
    
    @IBAction func slowSpeedTapped(_ sender: UIButton) {
        game.stop()
        simulationSpeed = 1.0
    }
    
    @IBAction func mediumSpeedTapped(_ sender: UIButton) {
        game.stop()
        simulationSpeed = 0.5
        
    }
    
    @IBAction func fastSpeedTapped(_ sender: UIButton) {
        game.stop()
        simulationSpeed = 0.3
    }
    
    @IBAction func colorSelection(_ sender: UISegmentedControl) {
        switch colorsSegmentedControl.selectedSegmentIndex {
            case 0:
                selectedColor = .blue
            case 1:
                selectedColor = .green
            case 2:
                selectedColor = .red
            default:
                selectedColor = .blue
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
        cell.configureWithState(dataSource[indexPath.item].isAlive, cellColor: selectedColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pixelSize, height: pixelSize)
    }
}
