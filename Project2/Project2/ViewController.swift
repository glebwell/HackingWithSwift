//
//  ViewController.swift
//  Project2
//
//  Created by Gleb on 11.08.2018.
//  Copyright © 2018 Gleb Maltsev. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

  @IBOutlet weak var button1: UIButton!
  @IBOutlet weak var button2: UIButton!
  @IBOutlet weak var button3: UIButton!

  @IBAction func buttonTapped(_ sender: UIButton) {
    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong"
      score -= 1
    }

    let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    present(ac, animated: true)
  }
  var countries = [String]()
  var correctAnswer = 0
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    countries.append("estonia")
    countries.append("france")
    countries.append("germany")
    countries.append("ireland")
    countries.append("italy")
    countries.append("monaco")
    countries.append("poland")
    countries.append("russia")
    countries.append("spain")
    countries.append("uk")

    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1

    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor


    askQuestion()
  }

  @objc func askQuestion(action: UIAlertAction! = nil) {
    countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
    title = countries[correctAnswer].uppercased()
  }
}























