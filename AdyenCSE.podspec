Pod::Spec.new do |s|
  s.name                    = 'AdyenCSE'
  s.version                 = '1.0.3'
  s.summary                 = 'AdyenCSE is a client side encryption library for credit card data.'
  s.description             = <<-DESC
    With CSE card data is encrypted within the client, in this case the iOS device, before you submit it via your own server to the Adyen API. By using CSE you reduce your scope of PCI compliance, because no raw card data travels through your server. This repository can be leveraged as a starting point to integrate Adyen's payment functionality fully in-app.
                            DESC
  s.homepage                = 'https://github.com/Adyen/AdyenCSE-iOS'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'Adyen' => 'support@adyen.com' }
  s.source                  = { :git => 'https://github.com/Adyen/AdyenCSE-iOS.git', :tag => "#{s.version}" }
  s.ios.deployment_target   = '7.0'
  s.source_files            = 'AdyenCSE/Classes/**/*'
  s.frameworks              = 'Foundation', 'Security'
end
