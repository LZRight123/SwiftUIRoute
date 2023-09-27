# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
target 'SwiftUIRoute' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for SwiftUIRoute
  pod 'PanModal' # slack 开源弹窗
  pod 'SwiftUIIntrospect', '~> 1.0' # 链接UIKIT
  # 扩展 语法糖
  pod 'SwifterSwift/SwiftStdlib'
  pod 'SwifterSwift/Foundation'
  pod 'SwifterSwift/Dispatch'
  
  pod 'Moya', '~> 15.0' # 网络底层
  #  pod 'Moya/Combine', '~> 15.0'# 网络底层结合SwiftUICombine
  pod 'KakaJSON', '~> 1.1.2' # JSON处理
  pod 'SwiftyJSON', '~> 4.0'# JSON处理
  pod 'Kingfisher', '~> 7.0'# Web图片
  pod 'MKProgress'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end
