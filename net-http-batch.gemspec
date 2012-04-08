Gem::Specification.new("net-http-batch", "1.0.0") do |gem|
  gem.authors       = ["James Tucker"]
  gem.email         = %w[jftucker@gmail.com]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/raggi/net-http-batch"

  gem.files         = `git ls-files`.split($\) - %w[Gemfile .gitignore]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.add_dependency "net-http-persistent"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "puma"
end
