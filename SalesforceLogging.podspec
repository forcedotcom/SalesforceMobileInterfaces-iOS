Pod::Spec.new do |s|
  s.name             = 'SalesforceLogging'
  s.version          = '1.1.0'
  s.summary          = 'Logging interface for Salesforce SDKs'
  s.description      = <<-DESC
                      Protocol and types for implementing logging functionality in Salesforce SDKs.
                      Allows plugins to utilize the logging system of a consuming application.
                      DESC
  s.homepage         = 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS'
  s.license          = { :type => "Apache 2.0" }
  s.author           = { 'Mobile Agentforce SDK' => 'mobile-agentforcesdk-public@salesforce.com' }
  s.source           = {
    :http   => "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS/releases/download/#{s.version}/SalesforceLogging.xcframework.zip",
    :sha256 => '51472af454df50f3f6ed6130606e61103eea28318337a8c8e0935650d1692d66'
  }

  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  s.vendored_frameworks = 'SalesforceLogging.xcframework'
end
