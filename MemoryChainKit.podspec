

Pod::Spec.new do |spec|

  
  spec.name         = "MemoryChainKit"
  spec.version      = "0.0.4"
  spec.summary      = "MemoryChain is a super tools to make iOS faster."


  spec.homepage     = "https://github.com/MarcSteven/MemoryChainKit"


  
  spec.license      = "MIT "


  
  spec.author             = { "MarcSteven" => "marczhao@memoriesus.com" }
  spec.social_media_url   = "https://twitter.com/MarcSteven"

  

   spec.ios.deployment_target = "12.0"
  

  
  spec.source       = { :git => "https://github.com/MarcSteven/MemoryChainKit.git", :tag => "#{spec.version}" }


  spec.swift_versions = ['5.0','5.1']
  spec.source_files  = "MemoryChainKit/Sources/**/*"
  spec.frameworks = ['UIKit','Foundation']
  

  
end
