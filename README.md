# Spider Web Chart
This project allows you to create a spider web chart with gradient. Screenshots are attached below.

![](https://github.com/sanchgoel/Spider-Web-Chart/blob/master/images/Sample%20Image%201.png)

## Installation Instructions
Cocopods Setup

## How to use
Sample usage with default values
``` 
func addSpiderWebChartView() {
    // Create a Spider Web Chart View with desired frame
    let graphView = SpiderWebChartView(frame: CGRect(x: 12.5,
                                                     y: 200,
                                                     width: 350,
                                                     height: 350))
    
    // Add the text for parameters
    graphView.parameters = ["Creativity", "Curiosity", "Eye For Detail", "Enthusiasm",
                            "Patience", "Risk Taking", "Resourcefulness", "Perseverance"]
    
    // Add the parameter values 0.0 - 1.0 for scale 1, 0.0 - 100.0 for scale 100
    graphView.parameterValues = [0.90, 0.78, 0.88, 0.75, 0.84, 0.65, 0.83, 0.95]
    graphView.scale = 1
    
    // Set background color of the view
    graphView.backgroundColor = UIColor.clear
    
    // Add the graph to the view
    self.view.addSubview(graphView)
  }
```

Sample usage with option to modify various components as per the requirement
```
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
```
