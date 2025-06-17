Pod::Spec.new do |s|
  s.name             = 'SalesforceUser'
  s.version          = '1.0.0'
  s.summary          = 'User management interface for Salesforce SDKs'
  s.description      = <<-DESC
                      Protocol and types for implementing user management functionality in Salesforce SDKs.
                      Allows plugins to utilize the user management system of a consuming application.
                      DESC
  s.homepage         = 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS'
  s.license          = { :type => "Apache 2.0", :file => "LICENSE.txt"}
  s.author           = { 'Salesforce' => 'mobile-sdk@salesforce.com' }
  s.source           = { :git => 'https://github.com/forcedotcom/SalesforceMobileInterfaces-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '16.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/SalesforceUser/**/*'
end 