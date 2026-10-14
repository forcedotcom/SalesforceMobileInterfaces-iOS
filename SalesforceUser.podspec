Pod::Spec.new do |s|
  s.name             = 'SalesforceUser'
  s.version          = '1.1.0'
  s.summary          = 'User management interface for Salesforce SDKs'
  s.description      = <<-DESC
                      Protocol and types for implementing user management functionality in Salesforce SDKs.
                      Allows plugins to utilize the user management system of a consuming application.
                      DESC
  s.homepage         = 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS'
  s.license          = { :type => "Apache 2.0" }
  s.author           = { 'Mobile Agentforce SDK' => 'mobile-agentforcesdk-public@salesforce.com' }
  s.source           = { :http => "https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS/releases/download/#{s.version}/SalesforceUser.xcframework.zip" }

  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  s.vendored_frameworks = 'SalesforceUser.xcframework'
end
