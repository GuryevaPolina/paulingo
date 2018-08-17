//
//  LearnViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

    let heightOfCollectionView: CGFloat = 120.0
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var languageCircleView: UIView!
    @IBOutlet var chooseLanguageView: UIView!
     var chooseLanguageIsOpen = false
    
    @IBOutlet weak var chooseLanguageButton: UIButton!
    @IBOutlet weak var flagsCollectionView: UICollectionView!
    var flagImages: [UIImage] = [#imageLiteral(resourceName: "uk"), #imageLiteral(resourceName: "germany"), #imageLiteral(resourceName: "israel"), #imageLiteral(resourceName: "denmark")]
    var currLanguageImage: UIImage = #imageLiteral(resourceName: "uk")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagsCollectionView.delegate = self
        flagsCollectionView.dataSource = self
        viewInit()
    }
    
    func viewInit() {
        chooseLanguageView.frame = CGRect(x: 0.0, y: navBarView.frame.maxY - heightOfCollectionView, width: view.frame.size.width, height: heightOfCollectionView)
        view.insertSubview(chooseLanguageView, at: 0)
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
    }
    
    func showView() {
        UIView.animate(withDuration: 0.5) {
            self.chooseLanguageView.frame.origin.y += self.chooseLanguageView.frame.size.height
        }
        chooseLanguageIsOpen = true
    }
    
    func hideView() {
        UIView.animate(withDuration: 0.5) {
            self.chooseLanguageView.frame.origin.y -= self.chooseLanguageView.frame.size.height
        }
        chooseLanguageIsOpen = false
    }
    
    @IBAction func chooseLanguageButtonTapped(_ sender: UIButton) {
        (!chooseLanguageIsOpen) ? showView() : hideView()
    }
    
    @objc func languageDidChoose(sender: UIButton) {
        chooseLanguageButton.setImage(flagImages[sender.tag], for: .normal)
        hideView()
    }
 
}

extension LearnViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flagImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flagCell", for: indexPath) as? FlagCollectionViewCell else {return UICollectionViewCell()}
        cell.button.tag = indexPath.row
        cell.button.setImage(flagImages[indexPath.row], for: .normal)
        cell.button.addTarget(self, action: #selector(languageDidChoose(sender:)), for: .touchUpInside)
        return cell
    }
    
}

extension LearnViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //flagsCollectionView.reloadData()
    }
    
}

extension LearnViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64 + 16, height: 64)
    }
    
}

