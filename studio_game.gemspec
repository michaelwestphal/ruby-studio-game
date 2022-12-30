Gem::Specification.new do |s|
  s.name         = "studio_game_michaelwestphal"
  s.version      = "1.0.1"
  s.author       = "Michael Westphal"
  s.email        = "michaelwestphal@hey.com"
  s.homepage     = "https://github.com/michaelwestphal/ruby-studio-game"
  s.summary      = "Studio Game from Pragmatic Studio Ruby course"
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=3.0'
  s.add_development_dependency 'rspec', '~> 3.10', '>= 3.10.0'
end
