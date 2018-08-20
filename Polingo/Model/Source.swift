//
//  Source.swift
//  Polingo
//
//  Created by Polina Guryeva on 17.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Source {
    static let flagImages: [UIImage] = [#imageLiteral(resourceName: "germany"), #imageLiteral(resourceName: "israel"), #imageLiteral(resourceName: "denmark"), #imageLiteral(resourceName: "italy"), #imageLiteral(resourceName: "norway")]
    static let topicImagesLabels: [(image: UIImage, label: String)] = [(#imageLiteral(resourceName: "phrases"), "Phrases"), (#imageLiteral(resourceName: "food"), "Food"), (#imageLiteral(resourceName: "animals"), "Animals"), (#imageLiteral(resourceName: "sport"), "Sport"), (#imageLiteral(resourceName: "clothes"), "Clothing"), (#imageLiteral(resourceName: "colors"), "Colors"), (#imageLiteral(resourceName: "questions"), "Qustions"), (#imageLiteral(resourceName: "family"), "Family"), (#imageLiteral(resourceName: "time"), "Time"), (#imageLiteral(resourceName: "travel"), "Travel"), (#imageLiteral(resourceName: "numbers"), "Numbers")]
    
    static let danish: [String: String] = ["Yes, thank you": "Ja, tak",
                                            "No": "Nej",
                                            "Hello": "Hej",
                                            "Good bye": "Farvel",
                                            "Sorry": "Undskyld",
                                            "Good morning": "Godmorgen",
                                            "Good evening": "Godaften",
                                            "Good night": "Godnat",
                                            "All right": "Det er ok",
                                            "I'll see you": "Vi ses"]
    
    static let randomEnglishWords = ["Dog", "Hello", "Good evening", "Black", "Pink", "Sorry", "Cat", "Mom", "Sister", "One", "Five", "Bus"]
    static let randomDanishWords = ["Spiser", "Nej", "Tak", "Det", "Godnat", "Vi ses", "Vand", "Kat", "Hund", "Kvinden", "Manden", "Pigen", "Hej", "Farvel"]
}

