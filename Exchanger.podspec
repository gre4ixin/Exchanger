Pod::Spec.new do |s|
    s.name = "Exchanger"
    s.version = "0.0.1"
    s.summary = "Summary"
    s.homepage = 'https://github.com/gre4ixin/Exchanger '
    s.description  = "Description"
    s.license = { :type => "MIT", :file => "License.md" }
    s.ios.deployment_target = "13.0"
    s.source = { :git => 'https://github.com/gre4ixin/Exchanger.git', :tag => '1.0.0' }
    s.author = "Pavel"
    s.source_files = "Sources/**"
    s.swift_version = "5.0"
    s.frameworks = "Combine"
    s.dependency 'Moya', '~> 15.0.0'
end