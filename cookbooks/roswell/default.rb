lisp = 'sbcl'
version = '1.5.6'
default = "#{lisp}/#{version}"
roswell_home = '$HOME/.roswell'
var = "ROSWELL_HOME=#{roswell_home}"


execute 'brew install roswell' do
  not_if 'type -p ros'
end

execute "#{var} ros setup" do
  not_if "test -d #{roswell_home}"
end

execute "#{var} ros install #{default}" do
  not_if "#{var} ros list installed | grep '#{default}'"
end

execute "#{var} ros use #{default}" do
  not_if "#{var} [ \"$(printf '%s/%s' $(ros config show default.lisp) $(ros config show #{lisp}.version))\" = '#{default}' ]"
end

execute "#{var} ros install slime" do
  not_if "test -f #{roswell_home}/helper.el"
end
