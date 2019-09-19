Pod::Spec.new do |s|
  s.name             = 'ArrayPlusTuple'
  s.version          = '2.1.0'
  s.swift_version    = '5.0'
  s.summary          = 'Simple extension that makes creating tuples from arrays a breeze.'

  s.description      = <<-DESC
Simple extension that makes creating tuples from arrays a breeze.
Originally created for MockNStub.
                       DESC

  s.homepage         = 'https://github.com/lvnkmn/ArrayPlusTuple'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mennolovink' => 'mclovink@me.com' }
  s.source           = { :git => 'https://github.com/lvnkmn/ArrayPlusTuple.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'ArrayPlusTuple/Classes/**/*'
  s.dependency 'InjectableLoggers', '~> 2'
end
