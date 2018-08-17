//
//  TopicCollectionViewCell.swift
//  Polingo
//
//  Created by Polina Guryeva on 17.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topicImage: UIButton!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var completeImage: UIImageView!
    var isCompleted = false
    
}
