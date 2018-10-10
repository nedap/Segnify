Pod::Spec.new do |s|
  s.name          = 'Segnify'
  s.version       = '1.0.0'
  s.summary       = 'An elegant, performing and fancy segmented component in Swift.'
  s.homepage      = 'https://github.com/nedap/Segnify'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { 'Bart Hopster' => 'bart.hopster@nedap.com' }
  
  s.platform      = :ios, '9.3'
  s.swift_version = '4.2'

  s.source        = { :git => 'https://github.com/nedap/Segnify.git', :tag => s.version }
  s.source_files  = 'Segnify/**/*.{swift}'
end
