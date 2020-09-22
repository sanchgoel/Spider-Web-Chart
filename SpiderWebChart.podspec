Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "SpiderWebChart"
s.summary = "This project allows you to create a spider web chart with gradient."
s.requires_arc = true

s.version = "1.0.1"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Sanchit Goel" => "sanch.goel@gmail.com" }

s.homepage = "https://github.com/sanchgoel/Spider-Web-Chart"

s.source = { :git => "https://github.com/sanchgoel/Spider-Web-Chart.git",
             :tag => "#{s.version}" }

s.framework = "UIKit"

s.source_files = "SpiderWebChart/**/*.{swift}"

s.swift_version = "5.0"

end
