Pod::Spec.new do |spec|
  spec.name         = "SSSKit"
  spec.version      = "1.0.2"
  spec.summary      = "SSSKit - USEFULL IOS LIBRARY IN SWIFT."

  spec.description  = <<-DESC
  SSSKit use Swfit to provide developers with usefull ios materials.
                   DESC

  spec.homepage     = "https://github.com/sncsuunc/SSKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Suu Nguyen"

  spec.platform     = :ios
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/sncsuunc/SSKit.git", :tag => spec.version }
  spec.source_files  = "Sources", "Sources/**/*.{swift}"
  spec.frameworks    = "UIKit", "Foundation"
  spec.swift_versions = "5.0"
end
