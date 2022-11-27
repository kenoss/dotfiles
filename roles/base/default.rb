include_cookbook 'functions'

case node[:platform]
when 'darwin' then
when 'ubuntu', 'debian' then
  package 'pkg-config'
when 'arch' then
  package 'pkgconf'
else
  raise "not supported platform: #{node[:platform]}"
end
