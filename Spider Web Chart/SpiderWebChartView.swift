//
//  SpiderWebChartView.swift
//  Spider Web Chart
//
//  Created by Sanchit Goel on 20/09/20.
//  Copyright © 2020 Sanchit Goel. All rights reserved.
//

import Foundation
import UIKit

class SpiderWebChartView: UIView {
      
  var bgWebColor = UIColor(hex: "#DFE6F1")
  var parameterLineStrokeColor = UIColor(hex: "#B5BFCF")
  var numberOfParameters = 8
  
  override func draw(_ rect: CGRect) {
    createWebBackground(rect: rect)
    addParamterLines(rect: rect)
  }
  
  func addParamterLines(rect: CGRect) {
    let radius = rect.width*0.75/2
    let center = CGPoint(x: rect.midX, y: rect.midY)
    for count in 0..<numberOfParameters {
      let angularDifference = 360.0/Double(numberOfParameters)
  
      let path = UIBezierPath()
      path.move(to: center)
      
      // Find the next point of polygon
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      let edgePoint = CGPoint(x: center.x + radius*CGFloat(cos(nextAngle)),
                              y: center.y + radius*CGFloat(sin(nextAngle)))
                  
      path.addLine(to: edgePoint)
      
      path.close()
      
      parameterLineStrokeColor?.set()
      path.lineWidth = 1.0
      path.stroke()
    }
  }
  
  func createWebBackground(rect: CGRect) {
    // Set the center and radius of polgons according to the parent view
    let radius = rect.width*0.75/2
    let center = CGPoint(x: rect.midX, y: rect.midY)
    drawConcentricBgPolygons(radius: radius, center: center)
  }
  
  func drawConcentricBgPolygons(radius: CGFloat,
                               center: CGPoint) {
    // Create and add shape layers for concentric polygons
    for count in 1...10 {
      let currentRadius = CGFloat(count) * 0.1 * radius
      drawPolygonPath(radius: currentRadius, center: center)
    }
  }
  
  func drawPolygonPath(radius: CGFloat, center: CGPoint) {
    // Create a shape layer and a bezier path
    let shape = CAShapeLayer()
    let path = UIBezierPath()
    
    // Set the first point of the polygon
    let firstPoint = CGPoint(x: center.x + radius*cos(0),
                             y: center.y + radius*sin(0))
    path.move(to: firstPoint)
        
    for count in 1..<numberOfParameters {
      // Find the difference of angles between two parameters
      let angularDifference = 360.0/Double(numberOfParameters)
      
      // Find the next point of polygon
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      let nextPoint = CGPoint(x: center.x + radius*CGFloat(cos(nextAngle)),
                              y: center.y + radius*CGFloat(sin(nextAngle)))
      
      // Add line to the next point
      path.addLine(to: nextPoint)
    }
        
    // Close the polygon
    path.close()
    
    // Set the path of the shape layer
    shape.path = path.cgPath
    
    // Set the fill and stroke colors
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = bgWebColor?.cgColor
    
    // Add the shapelayer to the view
    self.layer.addSublayer(shape)
  }
}
