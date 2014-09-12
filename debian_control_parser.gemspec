Gem::Specification.new do |s|
  s.name        = 'debian_control_parser'
  s.version     = '0.1'
  s.date        = '2014-09-11'
  s.summary     = "Parses Debian control files"
  s.description = <<-EOF
    Iterates over Debian control files. As control files can be very
    large this gem provides iterators for each block and each pair of
    key/values in the file.
    EOF
  s.author     = 'Christoph Haas'
  s.email      = 'email@christoph-haas.de'
  s.files      = ["lib/debian_control_parser.rb"]
  s.homepage   =
    'http://github.com/Signum/debian-control-parser-gem'
  s.license       = 'MIT'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
