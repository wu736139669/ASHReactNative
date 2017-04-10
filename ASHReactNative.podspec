
Pod::Spec.new do |s|
	s.name = 'ASHReactNative'
	s.version = '1.0'
	s.summary = 'ASHReactNative'
	s.description = 'ASHReactNative'
	s.license = 'MIT'
	s.homepage = 'https://github.com/wu736139669'
	s.authors = { 'ash' => '736139669@qq.com' }
	s.source = { :git => 'https://github.com/wu736139669/ASHReactNative.git' }
	s.requires_arc = true
	s.platform     = :ios
	s.ios.deployment_target = '8.0'

	s.source_files = 'Sources/**/*.{h,m}'

	s.dependency "AFNetworking"
	s.dependency "MBProgressHUD"
	s.dependency "ZipArchive"
	s.dependency "SDWebImage"

end

