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
    // Create a Spider Web Chart View with desired frame
    let graphView = SpiderWebChartView(frame: CGRect(x: 12.5,
                                                     y: 200,
                                                     width: 350,
                                                     height: 350))

    // Add the text for parameters
    graphView.parameters = ["Creativity", "Curiosity", "Eye For Detail", "Enthusiasm",
                            "Patience", "Risk Taking"]

    // Add the parameter values 0.0 - 1.0 for scale 1, 0.0 - 100.0 for scale 100
    graphView.parameterValues = [90, 78, 88, 95, 89, 83]
    graphView.scale = 100

    // Add trailing text to parameter values
    graphView.parameterValueTrailingText = "%"

    graphView.gradientColors = [UIColor(red: 210.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0),
                                UIColor(red: 221.0/255.0, green: 120.0/255.0, blue: 44.0/255.0, alpha: 1.0)]

    // Set background color of the view
    graphView.backgroundColor = UIColor.clear

    // Set Font Type and Color
    graphView.parameterFont = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
    graphView.parameterFontColor = UIColor.black

    // Set Distance Factor of Labels from center
    graphView.distanceOfLabelsFromCenter = 1.3

    // Set the color of bg Web lines
    graphView.bgWebColor = UIColor(red: 94.0/255.0, green: 107.0/255.0, blue: 127.0/255.0, alpha: 0.8)

    // Add the graph to the view
    self.view.addSubview(graphView)
  }
}
