source 'https://github.com/CocoaPods/Specs.git'

platform:ios,'8.0'
use_frameworks!
# ignore all warnings from all pods
inhibit_all_warnings!

def pods
    #Swift
    pod 'SwiftyBeaver'
    pod 'Alamofire', '~> 4.0'
    pod 'Kingfisher', '3.2.1'
    pod 'SwiftyJSON', '3.1.3'
    pod 'TimedSilver', '1.0.0'

    #Objective-C
    pod 'WechatOpenSDK'
    pod 'WeiboSDK'

end

target 'Car' do
    pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
