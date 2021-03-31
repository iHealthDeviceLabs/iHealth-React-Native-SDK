require "json"
package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "iHealth Library"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = "https://github.com/SynappzMA/iHealth-React-Native-SDK.git"
  s.license      = "ISC"
  s.author       = { "Synappz Digital Health" => "developer@synappz.nl" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/SynappzMA/iHealth-React-Native-SDK.git", :tag => s.version.to_s }
  s.source_files = "ios/**/*.{h,m}"
  s.public_header_files = "ios/ReactNativeIOSLibrary/Communication_SDK/Headers/*.h"
  s.vendored_libraries  = "ios/ReactNativeIOSLibrary/Communication_SDK/iHealthSDK2.7.2.a"
  s.requires_arc = true
  s.dependency "React"
end