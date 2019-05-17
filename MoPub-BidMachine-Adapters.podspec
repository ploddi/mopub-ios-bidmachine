#
#  Be sure to run `pod spec lint MoPub-BidMachine-Adapters.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
Pod::Spec.new do |spec|

  spec.name         = "MoPub-BidMachine-Adapters"
  spec.version      = "0.0.1"
  spec.summary      = "BidMachine IOS adapter for MoPub mediation"
  spec.description  = <<-DESC
  Supported ad formats: Banner, Interstitial, Rewarded Video.\n
                   DESC
  spec.homepage     = "https://github.com/appodeal/mopub-ios-bidmachine"
  spec.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
  Copyright 2019 Appodeal, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
    LICENSE
}

  spec.author       = { "Appodeal" => "http://www.appodeal.com" }
  spec.platform     = :ios, '9.0'
  spec.source       = { :git => "https://github.com/appodeal/mopub-ios-bidmachine.git", :branch => 'task-sdk-1104-prepare-bidmachine-mopub' }
  spec.source_files = 'BidMachine/**/*.{h,m}'
  spec.static_framework = true
  spec.dependency 'BidMachine', '~> 1.0'
  spec.dependency 'mopub-ios-sdk', '~> 5.5'

end
