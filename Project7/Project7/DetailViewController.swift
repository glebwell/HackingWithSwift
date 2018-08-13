//
//  DetailViewController.swift
//  Project7
//
//  Created by Gleb on 13.08.2018.
//  Copyright © 2018 Gleb Maltsev. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

  var webView: WKWebView!
  var detailItem: [String: String]!

  override func loadView() {
    webView = WKWebView()
    view = webView
  }

  override func viewDidLoad() {
    guard detailItem != nil else { return }

    if let body = detailItem["body"] {
      var html = "<html>"
      html += "<head>"
      html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
      html += "<style> body { font-size: 150%; } </style>"
      html += "</head>"
      html += "<body>"
      html += body
      html += "</body>"
      html += "</html>"

      webView.loadHTMLString(html, baseURL: nil)
    }
  }

}
