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
    addSpiderWebChartView()
  }
  
  func addSpiderWebChartView() {
    let graphView = SpiderWebChartView(frame: CGRect(x: 12.5,
                                                     y: 200,
                                                     width: 350,
                                                     height: 350))
    
    graphView.parameters = ["Creativity", "Curiosity", "Eye For Detail", "Enthusiasm",
                            "Patience", "Risk Taking", "Resourcefulness", "Perseverance"]
    
    graphView.parameterValues = [0.90, 0.78, 0.88, 0.75, 0.84, 0.65, 0.83, 0.95]
    
    graphView.scale = 1
    
    graphView.backgroundColor = UIColor.clear
    
    self.view.addSubview(graphView)
  }
}
