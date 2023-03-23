Pod::Spec.new do |s|
  s.name = 'Mixpanel-swift'
  s.version = '4.1.0'
  s.module_name = 'Mixpanel'
  s.license = 'Apache License, Version 2.0'
  s.summary = 'Mixpanel tracking library for iOS (Swift)'
  s.swift_version = '5.0'
  s.homepage = 'https://mixpanel.com'
  s.author       = { 'Mixpanel, Inc' => 'support@mixpanel.com' }
  s.source       = { :git => 'https://github.com/mixpanel/mixpanel-swift.git',
                     :tag => "v#{s.version}" }
  s.ios.deployment_target = '11.0'
  s.ios.frameworks = 'UIKit', 'Foundation', 'CoreTelephony'
  s.ios.pod_target_xcconfig = {
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) IOS'
  }
  s.default_subspec = 'Complete'
  base_source_files = ['Sources/Network.swift', 'Sources/FlushRequest.swift', 'Sources/PrintLogging.swift', 'Sources/FileLogging.swift',
    'Sources/Logger.swift', 'Sources/JSONHandler.swift', 'Sources/Error.swift', 'Sources/AutomaticProperties.swift',
    'Sources/Constants.swift', 'Sources/MixpanelType.swift', 'Sources/Mixpanel.swift', 'Sources/MixpanelInstance.swift',
    'Sources/Flush.swift','Sources/Track.swift', 'Sources/People.swift', 'Sources/AutomaticEvents.swift',
    'Sources/Group.swift',
    'Sources/ReadWriteLock.swift', 'Sources/SessionMetadata.swift', 'Sources/MPDB.swift', 'Sources/MixpanelPersistence.swift']
  s.tvos.deployment_target = '11.0'
  s.tvos.frameworks = 'UIKit', 'Foundation'
  s.tvos.pod_target_xcconfig = {
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) TV_OS'
  }
  s.osx.deployment_target = '10.13'
  s.osx.frameworks = 'Cocoa', 'Foundation'
  s.osx.pod_target_xcconfig = {
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) MAC_OS'
  }

  s.watchos.deployment_target = '4.0'
  s.watchos.pod_target_xcconfig = {
    'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) WATCH_OS'
  }

  s.subspec 'Complete' do |ss|
    ss.ios.source_files = ['Sources/*.swift']
    ss.tvos.source_files = base_source_files
    ss.osx.source_files = base_source_files
    ss.watchos.source_files = base_source_files
  end
  s.subspec 'SQLCipher' do |ss|
    ss.ios.source_files = ['Sources/*.swift']
    ss.tvos.source_files = base_source_files
    ss.osx.source_files = base_source_files
    ss.watchos.source_files = base_source_files
    ss.framework = 'Foundation'
    ss.dependency 'SQLCipher', '>= 3.4.2'
    ss.xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -D SQLITE_HAS_CODEC -D MPCIPHER -D SQLITE_ENABLE_FTS5',
      'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DMPCIPHER -DSQLITE_ENABLE_FTS5',
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SQLITE_HAS_CODEC=1 MPCIPHER=1 SQLITE_ENABLE_FTS5=1'
    }
  end

  s.subspec 'Core' do |ss|
    ss.ios.source_files = base_source_files
    ss.tvos.source_files = base_source_files
    ss.osx.source_files = base_source_files
    ss.watchos.source_files = base_source_files
  end
end
