include_cookbook 'functions'

case node[:platform]
when 'darwin' then
when 'ubuntu', 'debian' then
  package 'build-essential'
  package 'pkg-config'
when 'arch' then
  package 'base-devel'
  package 'pkgconf'
else
  raise "not supported platform: #{node[:platform]}"
end
