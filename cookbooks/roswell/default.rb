lisp = 'sbcl'
version = '1.5.6'
default = "#{lisp}/#{version}"
roswell_home = "#{ENV['HOME']}/.roswell"
var = "ROSWELL_HOME=#{roswell_home}"
ros = "#{ENV['HOME']}/.local/bin/ros"


local_repo = "#{ENV['HOME']}/src/github.com/roswell/roswell"

git local_repo do
  repository 'https://github.com/roswell/roswell'
  revision 'origin/release'
  user node[:user]
end

execute 'install roswell' do
  not_if "test -f #{ENV['HOME']}/.local/bin/ros"
  cwd local_repo
  user node[:user]
  command "sh bootstrap && ./configure --prefix=#{ENV['HOME']}/.local && make && make install"
end

execute "#{var} #{ros} setup" do
  not_if "test -d #{roswell_home}"
  user node[:user]
end

execute "#{var} #{ros} install #{default}" do
  not_if "#{var} #{ros} list installed | grep '#{default}'"
  user node[:user]
end

execute "#{var} #{ros} use #{default}" do
  not_if "#{var} [ \"$(printf '%s/%s' $(#{ros} config show default.lisp) $(#{ros} config show #{lisp}.version))\" = '#{default}' ]"
  user node[:user]
end

execute "#{var} #{ros} install slime" do
  not_if "test -f #{roswell_home}/helper.el"
  user node[:user]
end
