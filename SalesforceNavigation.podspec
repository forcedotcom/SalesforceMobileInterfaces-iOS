Pod::Spec.new do |s|
  s.name             = 'SalesforceNavigation'
  s.version          = '1.1.0'
  s.summary          = 'Navigation interface for Salesforce SDKs'
  s.description      = <<-DESC
                      Protocol and types for implementing navigation functionality in Salesforce SDKs.
                      Allows plugins to utilize the navigation system of a consuming application.
                      DESC
  s.homepage         = 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS'
  s.license          = { :type => "Apache 2.0" }
  s.author           = { 'Mobile Agentforce SDK' => 'mobile-agentforcesdk-public@salesforce.com' }
  s.source           = {
    :http   => "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS/releases/download/#{s.version}/SalesforceNavigation.xcframework.zip",
    :sha256 => '3cf225b705cb37d8c8f4625cc3690cf3ed6aae6655fab2dbf63df39b06bba58a'
  }

  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  s.vendored_frameworks = 'SalesforceNavigation.xcframework'
end
