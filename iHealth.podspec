require "json"
package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "iHealth"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.authors      = package['author']
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/SynappzMA/iHealth-React-Native-SDK.git", :tag => s.version.to_s }
  s.source_files = "ios/**/*.{h,m}"
  s.public_header_files = "ios/ReactNativeIOSLibrary/Communication_SDK/Headers/*.h"
  s.vendored_libraries  = "ios/ReactNativeIOSLibrary/Communication_SDK/libiHealthSDK2.7.3.a"
  s.requires_arc = true
  s.dependency "React"
end