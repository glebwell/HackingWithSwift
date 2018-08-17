//
//  ViewController.swift
//  Project8
//
//  Created by Gleb on 15.08.2018.
//  Copyright © 2018 Gleb Maltsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var cluesLabel: UILabel!
  @IBOutlet weak var answersLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var currentAnswer: UITextField!

  var letterButtons = [UIButton]()
  var activatedButtons = [UIButton]()
  var solutions = [String]()

  var score = 0
  var level = 1

  @IBAction func submitTapped(_ sender: UIButton) {
  }

  @IBAction func clearTapped(_ sender: UIButton) {
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    for subview in view.subviews where subview.tag == 1001 {
      let btn = subview as! UIButton
      letterButtons.append(btn)
      btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
    }
  }

  @objc func letterTapped(btn: UIButton) {

  }

  func loadLevel() {

  }
}

