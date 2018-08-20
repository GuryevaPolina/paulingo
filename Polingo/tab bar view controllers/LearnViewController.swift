//
//  LearnViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import AVFoundation

class LearnViewController: UIViewController {

    let heightOfCollectionView: CGFloat = 120.0
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var languageCircleView: UIView!
    @IBOutlet weak var scoreView: UIView!
    
    @IBOutlet var chooseLanguageView: UIView!
    var blurEffectView: UIVisualEffectView!
    
    var chooseLanguageIsOpen = false
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    @IBOutlet weak var chooseLanguageButton: UIButton!
    
    @IBOutlet weak var topicsCollectionView: UICollectionView!
    @IBOutlet weak var flagsCollectionView: UICollectionView!
    
    var levelEnabled: [Bool] = [true, false, false, false, false, false, false, false, false, false, false]
    
    var currLanguageImage: UIImage = #imageLiteral(resourceName: "denmark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagsCollectionView.delegate = self
        flagsCollectionView.dataSource = self
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        viewInit()
    }
    
    func viewInit() {
        chooseLanguageView.frame = CGRect(x: 0.0, y: navBarView.frame.maxY - heightOfCollectionView, width: view.frame.size.width, height: heightOfCollectionView)
       // view.insertSubview(chooseLanguageView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarView.layer.shadowColor = UIColor.lightGray.cgColor
        navBarView.layer.shadowOpacity = 1.0
        navBarView.layer.shadowOffset = .zero
        navBarView.layer.shadowRadius = 3.0
        navBarView.layer.masksToBounds = false
        
        languageCircleView.layer.shadowColor = UIColor.lightGray.cgColor
        languageCircleView.layer.shadowOpacity = 1.0
        languageCircleView.layer.shadowOffset = .zero
        languageCircleView.layer.shadowRadius = 1.0
        languageCircleView.layer.cornerRadius = 36.0
        languageCircleView.layer.masksToBounds = false
        languageCircleView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        scoreView.layer.shadowColor = UIColor.lightGray.cgColor
        scoreView.layer.shadowOpacity = 1.0
        scoreView.layer.shadowOffset = .zero
        scoreView.layer.shadowRadius = 1.0
        scoreView.layer.masksToBounds = false
    }
    
    func showView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.0
        view.insertSubview(blurEffectView, at: 1)
        view.insertSubview(chooseLanguageView, at: 2)
        UIView.animate(withDuration: 0.5) {
            self.chooseLanguageView.frame.origin.y += self.chooseLanguageView.frame.size.height
            self.blurEffectView.alpha = 1.0
        }
        chooseLanguageIsOpen = true
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.chooseLanguageView.frame.origin.y -= self.chooseLanguageView.frame.size.height
            self.blurEffectView.alpha = 0.0
        }) { (finished) in
            self.blurEffectView.removeFromSuperview()
            self.chooseLanguageView.removeFromSuperview()
        }
        chooseLanguageIsOpen = false
        
    }
    
    @IBAction func chooseLanguageButtonTapped(_ sender: UIButton) {
        (!chooseLanguageIsOpen) ? showView() : hideView()
    }
    
    @objc func languageDidChoose(_ sender: UIButton) {
        chooseLanguageButton.setImage(Source.flagImages[sender.tag], for: .normal)
        hideView()
    }
    
    @objc func topicDidChoose(_ sender: UIButton) {
//        print("\(Source.topicImagesLabels[sender.tag].label) topic was choosen")
//        let points = (sender.tag + 1) * 10
//        addPointsAnimation(points: points)
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topicVC") as? TopicViewController else {return}
        guard let navigator = navigationController else {return}
        navigator.pushViewController(vc, animated: true)
    }
    
    func addPointsAnimation(points: Int) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: view.frame.size.height / 4.0, width: view.frame.size.width, height: view.frame.size.height / 2.0))
        imageView.image = #imageLiteral(resourceName: "diamond")
        imageView.alpha = 0.3
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.6, animations: {
            imageView.alpha = 1.0
            imageView.frame.origin.x = self.view.frame.size.width / 2.0 - self.scoreImage.frame.size.width / 2.0
            imageView.frame.origin.y = self.view.frame.size.height / 2.0 - self.scoreImage.frame.size.height / 2.0
            imageView.frame.size.width = self.scoreImage.frame.size.width
            imageView.frame.size.height = self.scoreImage.frame.size.height
        }) { (_) in
            UIView.animate(withDuration: 0.6, animations: {
                imageView.frame.origin.x = self.scoreView.frame.origin.x + self.scoreImage.frame.origin.x
                imageView.frame.origin.y = self.scoreView.frame.origin.y + self.scoreImage.frame.origin.y
            }, completion: { (_) in
                self.score += points
                imageView.removeFromSuperview()
            })
        }
    }
 
}

extension LearnViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == flagsCollectionView {
            return Source.flagImages.count
        } else {
            return Source.topicImagesLabels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == flagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flagCell", for: indexPath) as? FlagCollectionViewCell else {return UICollectionViewCell()}
            cell.button.tag = indexPath.row
            cell.button.setImage(Source.flagImages[indexPath.row], for: .normal)
            cell.button.addTarget(self, action: #selector(languageDidChoose(_:)), for: .touchUpInside)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as? TopicCollectionViewCell else {return UICollectionViewCell()}
            cell.topicImage.tag = indexPath.row
            cell.topicImage.setImage(Source.topicImagesLabels[indexPath.row].image, for: .normal)
            cell.topicImage.addTarget(self, action: #selector(topicDidChoose(_:)), for: .touchUpInside)
            cell.topicLabel.text = Source.topicImagesLabels[indexPath.row].label
            if levelEnabled[indexPath.row] {
                cell.topicImage.isEnabled = true
                cell.topicLabel.isEnabled = true
            } else  {
                cell.topicImage.isEnabled = false
                cell.topicLabel.isEnabled = false
            }
            return cell
        }
        
    }
    
}

extension LearnViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //flagsCollectionView.reloadData()
    }
    
}

extension LearnViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == flagsCollectionView {
            return CGSize(width: 64 + 16, height: 64)
        } else {
            return CGSize(width: 170, height: 170)
        }
    }
    
}

