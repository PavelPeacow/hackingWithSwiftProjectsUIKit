//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Павел Кай on 04.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    
    var score = 0
    var correctAnswer = 0
    
    var count = 0
    var record = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedRecord = UserDefaults.standard.integer(forKey: "record")
        record = savedRecord
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.orange.cgColor
        button2.layer.borderColor = UIColor.orange.cgColor
        button3.layer.borderColor = UIColor.orange.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(showScore))
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Score: \(score), Flag to guess: \(countries[correctAnswer].uppercased())"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5,  options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        } completion: { isFinished in
            UIView.animate(withDuration: 0.5, delay: 0) {
                sender.transform = .identity
            }
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            count += 1
            if count > record {
                
                let ac = UIAlertController(title: "You beat a record", message: "Your previous record was \(record)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Rock-and-roll", style: .default, handler: askQuestion))
                record = count
                present(ac, animated: true)
            }
            save()
        } else {
            title = "Wrong! That's flag of \(countries[sender.tag].uppercased())"
            score -= 1
            count += 1
        }
        
//        if count == 10 {
//            title = "Game over"
//
//            score = 0
//            count = 0
//        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score", message: "Your score is \(score), record is \(record)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func save() {
        UserDefaults.standard.set(record, forKey: "record")
    }
    
}

