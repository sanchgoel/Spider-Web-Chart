//
//  ViewController.swift
//  Spider Web Chart
//
//  Created by Sanchit Goel on 20/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let view = SpiderWebChartView(frame: CGRect(x: 62.5, y: 200, width: 250, height: 250))
    view.parameters = ["Creativity", "Curiosity", "Eye For Detail", "Enthusiasm", "Patience", "Risk Taking", "Resourcefulness", "Perseverance"]
    view.parameterValues = [90, 78, 88, 75, 84, 65, 83, 95]
    view.backgroundColor = UIColor.clear
    self.view.addSubview(view)
  }

}
