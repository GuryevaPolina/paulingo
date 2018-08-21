//
//  CongratulationViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 21.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import AVFoundation

class CongratulationViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    var levelImage = UIImageView()
    var soundEffect = AVAudioPlayer()
    var crownImage = UIImageView()
    @IBOutlet weak var congratulationLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        circleAnimation()
        labelAnimation()
        self.playSound(name: "success.mp3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let circularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -.pi / 2.0, endAngle: 2 * .pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(cgColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)).cgColor
        shapeLayer.lineWidth = 30.0
        shapeLayer.strokeEnd = 0.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
        
        levelImage.frame = CGRect(x: view.frame.size.width / 2.0 - 100.0, y: view.frame.size.height / 2.0 - 100.0, width: 200.0, height: 200.0)
        view.addSubview(levelImage)
        
        congratulationLabel.alpha = 0.0
        
        crownImage.frame = CGRect(x: 0, y: view.frame.size.height / 2.0, width: view.frame.size.width, height: view.frame.size.height / 2.0)
        crownImage.image = #imageLiteral(resourceName: "crown")
        crownImage.alpha = 0.0
        view.addSubview(crownImage)
    }
    
    func playSound(name: String) {
        guard let completeSound = Bundle.main.path(forResource: name, ofType: nil) else {return}
        let url = URL(fileURLWithPath: completeSound)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect.prepareToPlay()
            soundEffect.play()
        }
        catch {
            print("error")
        }
    }
    
    func circleAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1.0
        basicAnimation.duration = 3.0
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func labelAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.congratulationLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.congratulationLabel.alpha = 1.0
        }) { (finished) in
            self.crownAnimation()
        }
    }
    
    func crownAnimation() {
        UIView.animate(withDuration: 2.0, animations: {
            UIView.animate(withDuration: 2.0, animations: {
                self.crownImage.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                self.crownImage.alpha = 1.0
                self.crownImage.frame.origin.x = self.levelImage.frame.maxX - self.crownImage.frame.size.width
                self.crownImage.frame.origin.y = self.levelImage.frame.maxY - self.crownImage.frame.size.height
            })
        }) { (finished) in
            self.continueButton.isHidden = false
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let navigator = navigationController else {return}
        for vc in navigator.viewControllers {
            if let tabVC = vc as? TabBarViewController {
                tabVC.learnVC.addPointsAnimation(points: 10)
                tabVC.learnVC.topicsCollectionView.reloadData()
                navigator.popToViewController(tabVC, animated: true)
            }
        }
    }
    
}
