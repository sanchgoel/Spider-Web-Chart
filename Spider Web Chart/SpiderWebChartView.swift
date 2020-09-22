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
  var parameterLineStrokeColor = UIColor(hex: "#5E6B7F")?.withAlphaComponent(0.8)
  var parameterFont = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
  var parameterFontColor = UIColor.black
  var parameters = [String]()
  var parameterValueTrailingText = ""
  var parameterValues = [CGFloat]()
  var gradientColors = [UIColor(hex: "309BFF")?.withAlphaComponent(0.9).cgColor,
                        UIColor(hex: "9848FF")?.withAlphaComponent(0.9).cgColor]
  var gradientLocations: [CGFloat] = [0.0, 1.0]
  var distanceOfLabelsFromCenter: CGFloat = 1.3
  var scale: CGFloat = 100.0
  
  override func draw(_ rect: CGRect) {
    createWebBackground(rect: rect)
    addLinesInDirectionOfParamters(rect: rect)
    plotValues(rect: rect)
    addParameterLabels(rect: rect)
  }
  
  func addLinesInDirectionOfParamters(rect: CGRect) {
    let radius = rect.width/2*0.65
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
    let radius = rect.width/2*0.65
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
    
    let radius = rect.width/2*0.65
    let center = CGPoint(x: rect.midX, y: rect.midY)
    
    path.lineWidth = 1.0
    UIColor.clear.setStroke()
        
    let currentParameterValue = parameterValues[0]/scale
    let deltaX = radius*cos(0)*currentParameterValue
    let deltaY = radius*sin(0)*currentParameterValue
    
    let firstPoint = CGPoint(x: center.x + deltaX,
                             y: center.y + deltaY)
    
    path.move(to: firstPoint)
    
    for count in 1..<parameterValues.count {
      let angularDifference = 360.0/Double(parameterValues.count)
      
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      
      let currentParameterValue = parameterValues[count]/scale
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
    let colors = gradientColors as CFArray
        
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let colorLocations: [CGFloat] = gradientLocations
        
    guard let gradient = CGGradient(colorsSpace: colorSpace,
                                    colors: colors,
                                    locations: colorLocations) else { return }
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    let startPoint = CGPoint(x: 0, y: 0)
    let endPoint = CGPoint(x: 1, y: bounds.maxY)
    
    // and lastly, draw the gradient.
    context.drawLinearGradient(gradient,
                               start: startPoint,
                               end: endPoint,
                               options: CGGradientDrawingOptions.drawsAfterEndLocation)
  }
  
  private func addParameterLabels(rect: CGRect) {
    let radius = rect.width/2*0.65
    let angularDifference = 360.0/Double(parameterValues.count)
    
    for count in 0..<parameters.count {
      // Find the next point of polygon
      let nextAngle = angularDifference * Double(count) * .pi / 180.0
      let xDisp = radius*CGFloat(cos(nextAngle))
      let yDisp = radius*CGFloat(sin(nextAngle))
      addStackView(xDisp: xDisp,
                   yDisp: yDisp,
                   parameterName: parameters[count],
                   parameterValue: "\(parameterValues[count])\(parameterValueTrailingText)")
    }
  }
  
  func addStackView(xDisp: CGFloat,
                    yDisp: CGFloat,
                    parameterName: String,
                    parameterValue: String) {
    
    // Heading Label
    let parameterLabel = UILabel()
    parameterLabel.font = parameterFont
    parameterLabel.textColor = parameterFontColor
    parameterLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    parameterLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    parameterLabel.text = parameterName
    parameterLabel.textAlignment = .center

    // Value Label
    let parameterValueLabel = UILabel()
    parameterValueLabel.textColor = parameterFontColor
    parameterValueLabel.font = parameterFont
    parameterValueLabel.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    parameterValueLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
    parameterValueLabel.text = "\(parameterValue)"
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
    stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor,
                                       constant: xDisp*distanceOfLabelsFromCenter).isActive = true
    stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                       constant: yDisp*distanceOfLabelsFromCenter).isActive = true
  }
}
