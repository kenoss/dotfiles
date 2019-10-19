node.reverse_merge!(
  ndenv: {
    user: node[:user],
    scheme: 'https',
    global: 'v12.12.0',
    versions: %w[
      v12.12.0
    ],
  },
)



node[:ndenv][:ndenv_root] = File.join(ENV['HOME'], '.ndenv')



###
### ndenv
###

package 'git'

ndenv = node[:ndenv]
raise 'Node does not include ndenv' if ndenv.nil?
git ndenv[:ndenv_root] do
  repository "#{ndenv[:scheme]}://github.com/riywo/ndenv.git"
  user ndenv[:user] if ndenv[:user]
end

git File.join(ndenv[:ndenv_root], 'plugins/node-build') do
  repository "#{ndenv[:scheme]}://github.com/riywo/node-build.git"
  user ndenv[:user] if ndenv[:user]
end

git File.join(ndenv[:ndenv_root], 'plugins/ndenv-yarn-install') do
  repository "#{ndenv[:scheme]}://github.com/pine/ndenv-yarn-install.git"
  user ndenv[:user] if ndenv[:user]
end

ndenv_init = "
  export NDENV_ROOT=#{ndenv[:ndenv_root]}
  export PATH=\"#{ENV['HOME']}/.ndenv/bin:$PATH\"
  eval \"$(ndenv init -)\"
"

ndenv[:versions].each do |version|
  execute "ndenv install #{version}" do
    command "#{ndenv_init} ndenv install #{version}"
    not_if  "#{ndenv_init} ndenv versions | grep #{version}"
    user ndenv[:user] if ndenv[:user]
  end
end

ndenv[:global].tap do |version|
  execute "ndenv global #{version}" do
    command "#{ndenv_init} ndenv global #{version}"
    not_if  "#{ndenv_init} ndenv version | grep #{version}"
    user ndenv[:user] if ndenv[:user]
  end
end
