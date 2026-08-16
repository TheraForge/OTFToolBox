#
# Be sure to run `pod lib lint Core.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OTFToolBoxCore'
  s.version          = '2.5.0'
  s.summary          = 'OTFToolBoxCore provides different types of file protection levels.'
  s.homepage         = 'https://github.com/TheraForge/OTFToolBox'
  s.license          = { :type => 'BSD-4', :file => 'LICENSE.md' }
  s.author           = { 'Hippocrates Technologies' => 'hippocratestech-dev@googlegroups.com' }
  s.source           = { :git => 'https://github.com/TheraForge/OTFToolBox.git', :tag => s.version.to_s }
  s.ios.deployment_target = '14.6'
  s.watchos.deployment_target = '8.0'
  s.swift_versions = '5.0'
  s.source_files = 'Core/**/*.{h,m,swift}'
end
