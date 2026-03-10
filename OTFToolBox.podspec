#
# Be sure to run 'pod lib lint OTFToolBox.podspec' to ensure this is a valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged.
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name 		= 'OTFToolBox'
  s.version 	= '2.0.0'
  s.summary 	= 'OTFToolBox is a parent framework for multiple other frameworks.'
  s.homepage	= 'https://github.com/TheraForge/OTFToolBox'
  s.license 	= { :type => 'BSD-4', :file => 'LICENSE.md' }
  s.author 	= { 'Hippocrates Technologies' => 'hippocratestech-dev@googlegroups.com' }
  s.source 	= { :git => 'https://github.com/TheraForge/OTFToolBox.git', :tag => s.version.to_s }
  s.swift_versions = '5.0'
  s.platform	= :ios
  s.ios.deployment_target = '16.0'
	
  s.dependency 'OTFToolBoxCore', '2.0.0'
  s.dependency 'OTFCloudClientAPI', '2.0.0'
  s.ios.dependency 'OTFDesignSystem', '2.0.0'
  s.ios.dependency 'OTFTemplateBox', '2.0.0'
  s.default_subspec = 'Care'

  s.subspec 'Care' do |ss|
    ss.pod_target_xcconfig = {
	    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited)'
	  }
	  ss.dependency 'OTFCloudantStore/CloudantCare', '2.0.0'
	  ss.dependency 'OTFCareKit/Care', '2.0.2-tf.2'
    ss.dependency 'OTFResearchKit', '2.0.0-tf.2'
  end

  s.subspec 'CareHealth' do |ss|
	  ss.pod_target_xcconfig = {
	    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited)'
	  }
	  ss.dependency 'OTFCloudantStore/CloudantCareHealth', '2.0.0'
	  ss.dependency 'OTFCareKit/CareHealth', '2.0.2-tf.2'
    ss.dependency 'OTFResearchKit', '2.0.0-tf.2'
  end
end
