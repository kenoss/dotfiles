include_cookbook 'functions'

case node[:platform]
when 'darwin' then
when 'ubuntu', 'debian' then
  package 'build-essential'
  package 'pkg-config'
  package 'libssl-dev'
when 'arch' then
  package 'base-devel'
  package 'pkgconf'
  package 'cmake'
  package 'unzip'
when 'fedora' then
  package 'make'
  package 'automake'
  package 'cmake'
  package 'gcc'
  package 'gcc-c++'
  package 'openssl-devel'
  package 'fontconfig-devel'
else
  raise "not supported platform: #{node[:platform]}"
end
