Gem::Specification.new do |s|
  s.name        = 'railroad'
  s.version     = '1.0.0'
  s.date        = '2020-09-06'
  s.summary     = 'ThinkNetica Basic Ruby School'
  s.description = 'Build RailRoad (Final lesson on ThinkNetica Basic Ruby School)'
  s.authors     = ['Aleksander Ruban']
  s.email       = 'a.p.ruban@gmail.com'
  s.files       = %w[
    lib/railroad.rb
    lib/railroad/accessors.rb
    lib/railroad/instance_counter.rb
    lib/railroad/interface.rb
    lib/railroad/manufacture.rb
    lib/railroad/route.rb
    lib/railroad/station.rb
    lib/railroad/string.rb
    lib/railroad/test_attr.rb
    lib/railroad/train_cargo.rb
    lib/railroad/train_passenger.rb
    lib/railroad/train.rb
    lib/railroad/validation_error.rb
    lib/railroad/validation.rb
    lib/railroad/wagon_cargo.rb
    lib/railroad/wagon_passenger.rb
    lib/railroad/wagon.rb
  ]
  s.files += Dir['lib/data/*']
  s.executables.push 'railroad'
  s.required_ruby_version = '>= 2.4'
  s.homepage    = 'http://rubygems.org/gems/railroad-lesson'
  s.license     = 'MIT'
end
