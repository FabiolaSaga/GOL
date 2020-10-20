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


}
