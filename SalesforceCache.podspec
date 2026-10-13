Pod::Spec.new do |s|
  s.name             = 'SalesforceCache'
  s.version          = '1.1.0'
  s.summary          = 'Caching interface for Salesforce SDKs'
  s.description      = <<-DESC
                      Protocol and types for implementing caching functionality in Salesforce SDKs.
                      Allows plugins to utilize the caching system of a consuming application.
                      DESC
  s.homepage         = 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS'
  s.license          = { :type => "Apache 2.0" }
  s.author           = { 'Mobile Agentforce SDK' => 'mobile-agentforcesdk-public@salesforce.com' }
  s.source           = {
    :http   => "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS/releases/download/#{s.version}/SalesforceCache.xcframework.zip",
    :sha256 => '28327b1fe84bc65462ae102b72de37f2b9dee6e32d9044a8237635cc481f6d62'
  }

  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  s.vendored_frameworks = 'SalesforceCache.xcframework'
end
