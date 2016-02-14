#############################################################################
#
# Packaging tasks
#
#############################################################################

desc "Release #{name} v#{version}"
task :release => :build do
  unless `git branch` =~ /^\* ruby$/
    puts "You must be on the ruby branch to release!"
    exit!
  end
  sh "git commit --allow-empty -m 'Release :gem: #{version}'"
  sh "git tag v#{version}"
  sh "git push origin ruby"
  sh "git push origin v#{version}"
  sh "gem push pkg/#{name}-#{version}.gem"
end

desc "Build #{name} v#{version} into pkg/"
task :build do
  mkdir_p "pkg"
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg"
end
