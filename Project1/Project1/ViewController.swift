//
//  ViewController.swift
//  Project1
//
//  Created by Gleb on 08.08.2018.
//  Copyright © 2018 Gleb Maltsev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }
    print(pictures)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

