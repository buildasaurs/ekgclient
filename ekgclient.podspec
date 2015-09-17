Pod::Spec.new do |s|

  s.name         = "ekgclient"
  s.version      = "0.2.3"
  s.summary      = "Swift SDK for sending events to ekg."

  s.description  = <<-DESC
                   Swift SDK for sending events to ekg, used by Buildasaur
                   for stats. See ekg: https://github.com/czechboy0/ekg
                   DESC

  s.homepage     = "https://github.com/czechboy0/ekgclient"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Honza Dvorsky" => "honzadvorsky.com" }
  s.social_media_url   = "http://twitter.com/czechboy0"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.source       = { :git => "https://github.com/czechboy0/ekgclient.git", :tag => "v#{s.version}" }

  s.source_files  = "ekgclient/*.{swift}"

  # load the dependencies from the podfile for target ekgclient
  podfile_deps = Podfile.from_file(Dir["Podfile"].first).target_definitions["ekgclient"].dependencies
  podfile_deps.each do |dep|
    s.dependency dep.name, dep.requirement.to_s
  end

end
