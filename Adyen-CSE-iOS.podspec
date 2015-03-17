Pod::Spec.new do |s|
  s.name         = "Adyen-CSE-iOS"
  s.version      = "1.0.1"
  s.summary      = "Sample code for client-side encryption on iOS"
  s.homepage     = "https://github.com/Adyen/CSE-iOS"
  # FIXME: set the license before submitting to cocoapods repo
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Adyen" => "support@adyen.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Adyen/CSE-iOS.git", :tag => "1.0.1" }
  s.source_files  = "ADYEncryption/*.{h,m}"
end
