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
    static let topicImagesLabels: [(image: UIImage, label: String)] = [(#imageLiteral(resourceName: "phrases"), "Phrases"), (#imageLiteral(resourceName: "food"), "Food"), (#imageLiteral(resourceName: "animals"), "Animals"), (#imageLiteral(resourceName: "clothes"), "Clothing"), (#imageLiteral(resourceName: "colors"), "Colors"), (#imageLiteral(resourceName: "family"), "Family"), (#imageLiteral(resourceName: "travel"), "Travel"), (#imageLiteral(resourceName: "numbers"), "Numbers")]
    
    static var levelEnabled = [true, false, false, false, false, false, false, false]
    static var levelCompleted = [false, false, false, false, false, false, false, false]
    
    static var currLevel = 0
    static let topic: [[String: String]] = [Source.danishPhrases, Source.danishFood, Source.danishAnimals, Source.danishClothes, Source.danishColors, Source.danishFamily, Source.danishTravel, Source.danishNumbers]
    
    static let danishPhrases = ["Yes, thank you": "Ja, tak",
                                "Hello": "Hej",
                                "Good bye": "Farvel",
                                "Sorry": "Undskyld",
                                "No, all right": "Nej, Det er ok",
                                "I'll see you": "Vi ses"]
    
    static let danishFood = ["Bread": "Brød",
                              "Cake": "Kage",
                              "Cheese": "Ost",
                              "Chicken": "Kylling",
                              "Egg": "æg",
                              "Lunch": "Frokost",
                              "Milk": "Mælk"]
    
    static let danishAnimals = ["Cat": "Kat",
                                "Dog": "Hund",
                                "Horse": "Hest",
                                "Bear": "Bjørn",
                                "Rabbit": "Kanin"]
    
    static let danishClothes = ["Coat": "Frakke",
                                "Dress": "Kjole",
                                "Shirt": "Skjorte",
                                "Jacket": "Jakke",
                                "Shoes": "Sko"]
    
    static let danishColors = ["Green": "Grøn",
                               "Red": "Rød",
                               "Yellow": "Gul",
                               "Black": "Sort",
                               "Color": "Farver"]
    
    static let danishFamily = ["Son": "Søn",
                               "Sister": "Søster",
                               "Brother": "Bror",
                               "Mom": "Mor",
                               "Dad": "Far"]
    
    static let danishTravel = ["Airport": "Lufthavn",
                               "Reservation": "Bestilling",
                               "Ticket": "Billet",
                               "Train": "Tog",
                               "Taxi": "Taxa"]
    
    static let danishNumbers = ["One": "En",
                                "Two": "To",
                                "Three": "Tre",
                                "Four": "Fire",
                                "Five": "Fem"]
    
    static let randomEnglishWords = ["Dog", "Hello", "Good evening", "Black", "Pink", "Sorry", "Cat", "Mom", "Sister", "One", "Five", "Bus"]
    static let randomDanishWords = ["Spiser", "Nej", "Tak", "Det", "Godnat", "Vi ses", "Vand", "Kat", "Hund", "Kvinden", "Manden", "Pigen", "Hej", "Farvel"]
}

