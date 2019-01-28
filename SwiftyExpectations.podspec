#
# Be sure to run `pod lib lint SwiftyExpectations.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyExpectations'
  s.version          = '1.0.0'
  s.summary          = 'A library which simplifies the Swift syntax around XCTExpectations'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SwiftyExpectations is a library which simplifies the syntax for using XCTExpectations when writing Unit Tests in Swift.
                       DESC

  s.homepage         = 'https://github.com/jaderfeijo/SwiftyExpectations'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jader Feijo' => 'jader@gojimo.co.uk' }
  s.source           = { :git => 'https://github.com/Jader Feijo/SwiftyExpectations.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/jaderfeijo'

  s.ios.deployment_target = '8.0'

	s.swift_version = '4.2'
  s.source_files = 'Sources/**/*'
  
  # s.resource_bundles = {
  #   'SwiftyExpectations' => ['SwiftyExpectations/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'XCTest'
  # s.dependency 'AFNetworking', '~> 2.3'
end
