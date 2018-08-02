platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'Happy App' do
  pod 'RxCocoa'
  pod 'SwiftLint'
  pod 'SwinjectStoryboard'
end

target 'Unit Tests' do
  pod 'RxTest'
  pod 'RxBlocking'
  pod 'Mockingjay'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
