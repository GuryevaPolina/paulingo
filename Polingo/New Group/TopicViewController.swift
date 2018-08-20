//
//  TopicViewController.swift
//  Polingo
//
//  Created by Polina Guryeva on 20.08.2018.
//  Copyright © 2018 polinaguryeva. All rights reserved.
//

import UIKit
import AVFoundation

class TopicViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var task: UILabel!
    
    @IBOutlet weak var var1: UIButton!
    @IBOutlet weak var var2: UIButton!
    @IBOutlet weak var var3: UIButton!
    @IBOutlet weak var var4: UIButton!
    
    @IBOutlet var correctAnswerView: UIView!
    @IBOutlet var wrongAnswerView: UIView!
    
    var isSelected = [false, false, false, false, false]
    var currTaskIndex = 0
    let countOfTasks = 10
    var countOfCorrectAnswers = 0
    
    var soundEffect = AVAudioPlayer()
    
    override func viewWillAppear(_ animated: Bool) {
        correctAnswerView.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 128.0)
        wrongAnswerView.frame = CGRect(x: 0, y: view.frame.size.height, width: view.frame.size.width, height: 128.0)
        view.insertSubview(correctAnswerView, at: 5)
        view.insertSubview(wrongAnswerView, at: 5)
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        progressView.progress = 0.0
        initView()
    }
    
    func initView() {
        var1.layer.shadowColor = UIColor.lightGray.cgColor
        var1.layer.shadowOpacity = 1.0
        var1.layer.shadowOffset = .zero
        var1.layer.shadowRadius = 3.0
        var1.layer.masksToBounds = false
        
        var2.layer.shadowColor = UIColor.lightGray.cgColor
        var2.layer.shadowOpacity = 1.0
        var2.layer.shadowOffset = .zero
        var2.layer.shadowRadius = 3.0
        var2.layer.masksToBounds = false
        
        var3.layer.shadowColor = UIColor.lightGray.cgColor
        var3.layer.shadowOpacity = 1.0
        var3.layer.shadowOffset = .zero
        var3.layer.shadowRadius = 3.0
        var3.layer.masksToBounds = false
        
        var4.layer.shadowColor = UIColor.lightGray.cgColor
        var4.layer.shadowOpacity = 1.0
        var4.layer.shadowOffset = .zero
        var4.layer.shadowRadius = 3.0
        var4.layer.masksToBounds = false
        
        fillTask()
    }
    
    func fillTask() {
        
        task.text = Array(Source.danish)[currTaskIndex].key
        
        let n = Int(arc4random() % 4 + 1)
        guard let button = view.viewWithTag(n) as? UIButton else {return}
        button.setTitle(Array(Source.danish)[currTaskIndex].value, for: .normal)
        
        for i in 1..<isSelected.count {
            if i != n {
                guard let variant = view.viewWithTag(i) as? UIButton else {return}
                let random: Int = Int(Int(arc4random()) % Source.randomDanishWords.count)
                variant.setTitle(Source.randomDanishWords[random], for: .normal)
            }
        }
        
    }

    @IBAction func exitButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to quit?", message: "All progress in this session will be lost", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { (_) in
            guard let navigator = self.navigationController else {return}
            navigator.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func var1Tapped(_ sender: UIButton) {
        isSelected[sender.tag] = !isSelected[sender.tag]
        if isSelected[sender.tag] {
            deselectAnotherVariants(newSelectionIndex: sender.tag)
            sender.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        } else {
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            sender.setTitleColor(#colorLiteral(red: 0.1764705882, green: 0.2, blue: 0.262745098, alpha: 1), for: .normal)
        }
    }
    
    func deselectAnotherVariants(newSelectionIndex: Int) {
        for index in 1..<isSelected.count {
            if index != newSelectionIndex && isSelected[index] {
                isSelected[index] = false
                guard let button = view.viewWithTag(index) as? UIButton else {return}
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 0.1764705882, green: 0.2, blue: 0.262745098, alpha: 1), for: .normal)
            }
        }
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
    
    func correctAnswerAnimation() {
        playSound(name: "complete_sound.mp3")
        UIView.animate(withDuration: 0.5) {
            self.correctAnswerView.frame.origin.y = self.view.frame.size.height / 2.0
        }
    }
    
    func uncorrectAnswerAnimation() {
        playSound(name: "wrong_sound.mp3")
        UIView.animate(withDuration: 0.5) {
            self.wrongAnswerView.frame.origin.y = self.view.frame.size.height / 2.0
        }
    }
    
    func hideCorrectAnswerAnimation(subview: UIView) {
        UIView.animate(withDuration: 0.5) {
            subview.frame.origin.y = self.view.frame.size.height
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        if currTaskIndex == countOfTasks - 1 {
            let alert = UIAlertController(title: "Level complete!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool!", style: .default, handler: { (_) in
                guard let navigator = self.navigationController else {return}
                navigator.popViewController(animated: true)
            }))
            present(alert, animated: true)
            return
        }
        currTaskIndex += 1
        fillTask()
        progressView.progress = Float(currTaskIndex) / Float(countOfTasks)
        hideCorrectAnswerAnimation(subview: correctAnswerView)
    }
    
    @IBAction func continueButtonTappedWrong(_ sender: UIButton) {
        if currTaskIndex == countOfTasks - 1 {
            let alert = UIAlertController(title: "Level complete!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool!", style: .default, handler: { (_) in
                guard let navigator = self.navigationController else {return}
                navigator.popViewController(animated: true)
            }))
            present(alert, animated: true)
            return
        }
        currTaskIndex += 1
        fillTask()
        progressView.progress = Float(currTaskIndex) / Float(countOfTasks)
        hideCorrectAnswerAnimation(subview: wrongAnswerView)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        
        for i in 1..<isSelected.count {
            if isSelected[i] {
                guard let variant = view.viewWithTag(i) as? UIButton else {return}
                isSelected[i] = false
                variant.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                variant.setTitleColor(#colorLiteral(red: 0.1764705882, green: 0.2, blue: 0.262745098, alpha: 1), for: .normal)
                
                if variant.title(for: .normal) == Source.danish[task.text!] {
                    correctAnswerAnimation()
                } else {
                    uncorrectAnswerAnimation()
                }
            }
        }
        
    }
    

}
