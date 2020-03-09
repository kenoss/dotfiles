node.reverse_merge!(
  pyenv: {
    user: node[:user],
    scheme: 'git',
    global: '3.6.10',
    versions: %w[
      3.6.10
    ],
  }
)



node[:pyenv][:pyenv_root] = File.join(ENV['HOME'], '.pyenv')



###
### pyenv
###

# Original: plugins/itamae-plugin-recipe-pyenv/lib/itamae/plugin/recipe/pyenv/install.rb

case node[:platform]
when 'debian', 'ubuntu'
  package 'build-essential'
when 'redhat', 'fedora', 'amazon'
  package 'gcc'
  package 'zlib-devel'
  package 'openssl-devel'
end

package 'git'

pyenv = node[:pyenv]
raise 'Node does not include pyenv' if pyenv.nil?
git pyenv[:pyenv_root] do
  repository "#{pyenv[:scheme]}://github.com/pyenv/pyenv.git"
  user pyenv[:user] if pyenv[:user]
end

pyenv_init = "
  export PYENV_ROOT=#{pyenv[:pyenv_root]}
  export PATH=#{pyenv[:pyenv_root]}/bin:$PATH
  eval \"$(pyenv init -)\"
"

pyenv[:versions].each do |version|
  execute "pyenv install #{version}" do
    command "#{pyenv_init} pyenv install #{version}"
    not_if  "#{pyenv_init} pyenv versions | grep #{version}"
    user pyenv[:user] if pyenv[:user]
  end
end

pyenv[:global].tap do |version|
  execute "pyenv global #{version}" do
    command "#{pyenv_init} pyenv global #{version}"
    not_if  "#{pyenv_init} pyenv version | grep #{version}"
    user pyenv[:user] if pyenv[:user]
  end
end



###
### pip
###

define :pip do
  name = params[:name]
  execute "#{pyenv_init} pip install #{name}" do
    not_if "#{pyenv_init} pip freeze | grep '^#{name}==' >/dev/null"
  end
end
