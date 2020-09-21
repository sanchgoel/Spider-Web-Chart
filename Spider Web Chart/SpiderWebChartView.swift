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
      
  var bgWebColor = UIColor(hex: "#5E6B7F")?.withAlphaComponent(0.8)
  var parameterLineStrokeColor = UIColor(hex: "#707781")?.withAlphaComponent(0.8)
  var parameters = [String]()
  var parameterValues = [Int]()
  
  override func draw(_ rect: CGRect) {
    createWebBackground(rect: rect)
    addParamterLines(rect: rect)
    plotValues(rect: rect)
    addParameterLabels(rect: rect)
  }
  
  func addParamterLines(rect: CGRect) {
    let radius = rect.width/2
    let center = CGPoint(x: rect.midX, y: rect.midY)
    for count in 0..<parameterValues.count {
      let angularDifference = 360.0/Double(parameterValues.count)
  
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
    let radius = rect.width/2
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
        
    for count in 1..<parameterValues.count {
      // Find the difference of angles between two parameters
      let angularDifference = 360.0/Double(parameterValues.count)
      
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
  
  func plotValues(rect: CGRect) {
    let path = UIBezierPath()
    
    let radius = rect.width/2
    let center = CGPoint(x: rect.midX, y: rect.midY)
    
    path.lineWidth = 1.0
    UIColor.clear.setStroke()
        
    let currentParameterValue = CGFloat(parameterValues[0])/100.0
    let deltaX = radius*cos(0)*currentParameterValue
    let deltaY = radius*sin(0)*currentParameterValue
    
    let firstPoint = CGPoint(x: center.x + deltaX,
                             y: center.y + deltaY)
    
    path.move(to: firstPoint)
    
    for count in 1..<parameterValues.count {
      let angularDifference = 360.0/Double(parameterValues.count)
      
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      
      let currentParameterValue = CGFloat(parameterValues[count])/100
      let nextDeltaX = radius*CGFloat(cos(nextAngle))*currentParameterValue
      let nextDeltaY = radius*CGFloat(sin(nextAngle))*currentParameterValue
      
      let nextPoint = CGPoint(x: center.x + nextDeltaX,
                              y: center.y + nextDeltaY)
      path.addLine(to: nextPoint)
    }
    path.close()
    
    path.addClip()
    addGradient()
  }
  
  func addGradient() {
    // create and add the gradient
    let colors = [UIColor(red: 48.0/255.0, green: 155.0/255.0, blue: 255.0/255.0, alpha: 0.8).cgColor,
                  UIColor(red: 152.0/255.0, green: 72.0/255.0, blue: 255.0/255.0, alpha: 0.8).cgColor] as CFArray
        
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let colorLocations:[CGFloat] = [0.0, 1.0]
        
    guard let gradient = CGGradient(colorsSpace: colorSpace,
                                    colors: colors,
                                    locations: colorLocations) else { return }
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    let startPoint = CGPoint(x: 1, y: 1)
    let endPoint = CGPoint(x: 1, y: bounds.maxY)
    
    // and lastly, draw the gradient.
    context.drawLinearGradient(gradient,
                               start: startPoint,
                               end: endPoint,
                               options: CGGradientDrawingOptions.drawsAfterEndLocation)
  }
  
  private func addParameterLabels(rect: CGRect) {
    let radius = rect.width/2
    let angularDifference = 360.0/Double(parameterValues.count)
    
    for count in 0..<parameters.count {
      // Find the next point of polygon
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      let xDisp = radius*CGFloat(cos(nextAngle))
      let yDisp = radius*CGFloat(sin(nextAngle))
      addStackView(xDisp: xDisp,
                   yDisp: yDisp,
                   parameterName: parameters[count],
                   parameterValue: parameterValues[count])
    }
  }
  
  func addStackView(xDisp: CGFloat,
                    yDisp: CGFloat,
                    parameterName: String,
                    parameterValue: Int) {
    
    // Heading Label
    let parameterLabel = UILabel()
    parameterLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
    parameterLabel.textColor = UIColor.black
    parameterLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    parameterLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    parameterLabel.text = parameterName
    parameterLabel.textAlignment = .center

    // Value Label
    let parameterValueLabel = UILabel()
    parameterValueLabel.textColor = UIColor.black
    parameterValueLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
    parameterValueLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    parameterValueLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    parameterValueLabel.text = "\(parameterValue)%"
    parameterValueLabel.textAlignment = .center

    // Stack View
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.vertical
    stackView.distribution = UIStackView.Distribution.equalSpacing
    stackView.alignment = UIStackView.Alignment.center
    stackView.spacing = 0.0

    stackView.addArrangedSubview(parameterLabel)
    stackView.addArrangedSubview(parameterValueLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(stackView)

    // Constraints
    stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: xDisp*1.22).isActive = true
    stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: yDisp*1.22).isActive = true
  }
}
