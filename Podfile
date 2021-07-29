# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UpcomingMovies' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UpcomingMovies

  target 'UpcomingMoviesTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'ViewInspector'
  end

  target 'UpcomingMoviesUITests' do
    # Pods for testing
  end

  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['ViewInspector'].include? target.name
          target.build_configurations.each do |config|
              config.build_settings['ENABLE_BITCODE'] = 'NO'
          end
      end
    end
  end
end
