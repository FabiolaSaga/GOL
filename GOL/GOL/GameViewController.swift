//
//  GameViewController.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import UIKit

class GameViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var backgroundGradient: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackgroundColor()
        // Do any additional setup after loading the view.
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
