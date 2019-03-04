require 'rake/extensiontask'
require 'rubygems/package_task'

Rake::ExtensionTask.new 'sqlite' do |ext|
  ext.lib_dir = 'lib/sqlite'
end

s = Gem::Specification.new 'sqlite', '1.0.3' do |s|
  s.name = 'sqlite'
  s.summary = 'Small, Simple SQLite extension'
  s.authors = %w[mikeowens@gmail.com]
  s.homepage = 'https://github.com/mikeowens/SQLiteRuby'
  s.license = 'MIT'
  s.extensions = %w[ext/sqlite/extconf.rb]
  s.files = %w[
    MIT-LICENSE
    Rakefile
    ext/sqlite/extconf.rb
    ext/sqlite/main.c
    ext/sqlite/sqlite3_dist.c
    ext/sqlite/ruby_sqlite3.c
    ext/sqlite/ruby_sqlite3.h
    ext/sqlite/ruby_sqlite3_stmt.c
    ext/sqlite/ruby_sqlite3_stmt.h
    lib/sqlite.rb
  ]
end

Gem::PackageTask.new s do end
task test: %w[compile] do
  ruby '-Ilib', '-rsqlite', '-e', 'p SQLite::Database.new()'
end

task default: :test
