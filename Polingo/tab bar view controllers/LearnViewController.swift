//
//  LearnViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 15.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

    let heightOfCollectionView: CGFloat = 80.0
    
    @IBOutlet var chooseLanguageView: UIView!
    
    @IBOutlet weak var flagsCollectionView: UICollectionView!
    var flagImages: [UIImage] = [#imageLiteral(resourceName: "uk"), #imageLiteral(resourceName: "germany"), #imageLiteral(resourceName: "israel"), #imageLiteral(resourceName: "denmark")]
    var currLanguageImage: UIImage = #imageLiteral(resourceName: "uk")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagsCollectionView.delegate = self
        flagsCollectionView.dataSource = self
        
        chooseLanguageView.frame = CGRect(x: 0, y: -heightOfCollectionView, width: view.frame.size.width, height: heightOfCollectionView)
        view.insertSubview(chooseLanguageView, at: 0)
    }
    
    public func moveChooseLanguageView() {
        UIView.animate(withDuration: 0.3) {
            self.chooseLanguageView.frame.origin.y += self.chooseLanguageView.frame.size.height
        }
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
        cell.button.setImage(flagImages[indexPath.row], for: .normal)
        print(flagImages[indexPath.row])
        return cell
    }
    
}

extension LearnViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currLanguageImage = flagImages[indexPath.row]
        UIView.animate(withDuration: 0.3) {
            self.chooseLanguageView.frame.origin.y -= self.chooseLanguageView.frame.size.height
        }
        flagsCollectionView.reloadData()
    }
    
}

extension LearnViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64 + 16, height: 64)
    }
    
}

