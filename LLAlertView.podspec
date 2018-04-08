

Pod::Spec.new do |s|
  s.name             = 'LLAlertView'
  s.version          = '0.1.0'
  s.summary          = '自定义提示框，类似UIAlertView的使用.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lypcliuli/LLAlertView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lypcliuli' => 'lypcliuli@163.com' }
  s.source           = { :git => 'https://github.com/lypcliuli/LLAlertView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'LLAlertView/Classes/**/*'
 
end
